# Water Level App with AWS Amplify serverless cloud

This app uses AWS Amplify serverless cloud architecture.
 
![](https://github.com/Obaidiaa/water-level-app-amplify-flutter/blob/main/aws%20serverless%20.png?raw=true)


## Getting Started

1. Install Prerequisites https://docs.amplify.aws/start/getting-started/installation/q/integration/flutter/
2. Generate model files https://docs.amplify.aws/start/getting-started/generate-model/q/integration/flutter/
3. Create IoT policies in the AWS IoT Core. The policies are in the "IoT policies" folder.
4. Some AWS permissions are not created by themself. You may need to create them.

## There are two functions: 
1. AttachPolicyToUser: Attach the user to the IoT policy to allow them to communicate with AWS IoT Core.
2. ThingOwnerManager: Allow the user to claim and declaim a device.

## IoT Topic used:
1. "thing/attributes": To get device "ownerId" from the attributes.
2. "$aws/rules/IoT_To_TimeStream": To send data to the AWS Timestream database.
3. "{username}/{deviceid}/currentdata": Request level data.
4. "{username}/{deviceid}/level": Send level data.

## To Do:
1. Get historical data from Timestream.

Maybe there are things I forgot to write here if you encounter any issues reported.
