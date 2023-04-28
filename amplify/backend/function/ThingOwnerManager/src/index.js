

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
const AWS = require('aws-sdk');
const iot = new AWS.Iot();
const dynamodb = new AWS.DynamoDB();
const deviceTable = "Device-fw67otn32ncune3gcn75zh4vjm-staging";

exports.handler = async (event, context) => {
    const { serialNumber, action } = event.arguments;
    console.log(deviceTable);
    // try {
    // Get the current attributes of the Thing
    const params = {
        thingName: serialNumber
    };

    let result;
    try {
        result = await iot.describeThing(params).promise();
    } catch (e) {
        throw e.code;
    }


    const currentAttributes = result.attributes || {};
    const currentOwner = currentAttributes.owner;

    // Check if the authenticated user is the current owner of the Thing, or if the Thing has no owner
    const isOwner = event.identity.claims.sub === currentOwner;
    const isNoOwner = !currentOwner;
    let message = "Unauthorized";

    if (!isOwner && !isNoOwner && currentOwner != "false") {
        throw new Error('Unauthorized');
    }

    message = "declaim SUCCESS";
    let updateParams = {
        thingName: serialNumber,
        attributePayload: {
            attributes: {
                owner: "false"
            },
            merge: true
        }
    };

    // Update the DynamoDB table
    let updateParamsDB = {
        TableName: deviceTable,
        Key: { 'serialNumber': { 'S': serialNumber } },
        UpdateExpression: 'set #owner = :owner',
        ExpressionAttributeNames: { '#owner': 'owner' },
        ExpressionAttributeValues: { ':owner': { 'S': "false" } }
    };


    let rollbackDBParams = null;
    let rollbackIOTParams = null;
    let rollbackFunction = null;

    // Fetch the device record from DynamoDB
    const dynamoParams = {
        TableName: deviceTable,
        Key: { 'serialNumber': { S: serialNumber } }
    };
    const dynamoResult = await dynamodb.getItem(dynamoParams).promise();
    const dynamoItem = dynamoResult.Item || {};
    const dynamoOwner = dynamoItem.owner && dynamoItem.owner.S;
    const isDynamoOwner = dynamoOwner === currentOwner;
    console.log(dynamoOwner);

    if (action === "claim") {
        if (isOwner && isDynamoOwner) {
            return { serialNumber, owner: event.identity.claims.sub, status: 200, message: "device already in your account", action: action };
        }
        // Update the Thing's owner attribute
        message = "claim SUCCESS";
        updateParams = {
            thingName: serialNumber,
            attributePayload: {
                attributes: {
                    owner: event.identity.claims.sub
                },
                merge: true
            }
        };

        // Update the DynamoDB table
        updateParamsDB = {
            TableName: deviceTable,
            Key: { 'serialNumber': { 'S': serialNumber } },
            UpdateExpression: 'set #owner = :owner',
            ExpressionAttributeNames: { '#owner': 'owner' },
            ExpressionAttributeValues: { ':owner': { 'S': event.identity.claims.sub } }
        };
    }


    // Prepare rollback params and function
    rollbackDBParams = {
        TableName: deviceTable,
        Key: { 'serialNumber': { 'S': serialNumber } },
        UpdateExpression: 'set #owner = :owner',
        ExpressionAttributeNames: { '#owner': 'owner' },
        ExpressionAttributeValues: { ':owner': { 'S': dynamoOwner } }
    };

    rollbackIOTParams = {
        thingName: serialNumber,
        attributePayload: {
            attributes: {
                owner: currentOwner
            },
            merge: true
        }
    };


    rollbackFunction = async () => {
        await iot.updateThing(rollbackIOTParams).promise();
        await dynamodb.updateItem(rollbackDBParams).promise();
    };


    try {
        // Update the Thing's attributes
        await iot.updateThing(updateParams).promise();
        await dynamodb.updateItem(updateParamsDB).promise();
    } catch (error) {
        // Rollback changes if an error occurs
        if (rollbackFunction) {
            await rollbackFunction();
        }
        throw error;
    }



    // await iot.updateThing(updateParams).promise();

    // Return the updated Thing object
    return { serialNumber, owner: event.identity.claims.sub, status: 200, message: message, action: action };

    // } catch (error) {
    //     console.error(error);
    //     return { serialNumber, owner: event.identity.claims.sub, status: 400, message:error.message, action: action };
    // }
};

