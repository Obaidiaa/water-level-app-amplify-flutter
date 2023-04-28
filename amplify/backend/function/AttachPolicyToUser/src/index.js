

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
var AWS = require('aws-sdk');
var iot = new AWS.Iot();
var cognitoidentity = new AWS.CognitoIdentity();

exports.handler = async (event) => {
    console.log(`EVENT: ${JSON.stringify(event)}`);
    
  return await GetIdentityId(event.arguments.username).then(id =>
        AttachIoTPolicy("IoT_Cognito_Users", id.IdentityId).then(() => {
          return { status: 200,message: "attached success"};
        }).catch(e => {   return {status: 400,message: e};})
    ).catch(e => {    return {status: 400,message: e};});
};


function GetIdentityId(Authorization) {
  
  var params = {
    IdentityPoolId: 'us-east-2:6373a0fb-6875-4d88-b77f-68c1de6a6d0a',
    Logins: {
      'cognito-idp.us-east-2.amazonaws.com/us-east-2_Y9ZbWdf7r': Authorization,
    }
  };
  let promise = new Promise((resolve, reject) => {
    cognitoidentity.getId(params, function(err, data) {
      if (err) {
        reject(err);
      }
      else {
        resolve(data);
      }
    });
  });
  return promise;
}

function AttachIoTPolicy(policyName, IdentityId) {
  var iotParams = {
    policyName: policyName,
    target: IdentityId
  };
  console.log(iotParams);
  let promise = new Promise((resolve, reject) => {
    iot.attachPolicy(iotParams, function(err, data) {
      if (err) {
        reject(err);
      }
      else {
        resolve(data);
      }
    });
  });
  return promise;
}