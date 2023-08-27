/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
var AWS = require('aws-sdk');
var iot = new AWS.Iot();

exports.handler = async (event) => {
  console.log(`EVENT: ${JSON.stringify(event)}`);

  return await AttachIoTPolicy("IoT_Cognito_Users", event.arguments.username).then(() => {
    return { status: 200, message: "attached success" };
  }).catch(e => { return { status: 400, message: e }; });

};


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
