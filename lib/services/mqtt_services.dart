import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/main.dart';
import 'package:water_level_flutter/packages/mqtt_aws_iot.dart';

final mqttServicesProvider = Provider<MqttServices>((ref) {
  return MqttServices(ref);
});

// statenotiffer for data from mqtt
final devicesLevelData = StateProvider<Map<String, List<dynamic>>>((ref) => {});

// Map<String, dynamic> devicesLevelData = {};

final mqttStatusNotifier = StateProvider<bool?>((ref) => false);

class MqttServices {
  // MqttServices(this.ref);
  Ref ref;
  MqttServices(this.ref) {
    init();
  }

  late MqttServerClient client;
  late String username;

  init() async {
    CognitoAuthSession awsCredentials = await fetchCognitoAuthSession();
    String? accessKey = awsCredentials.credentialsResult.value.accessKeyId;
    String? secretKey = awsCredentials.credentialsResult.value.secretAccessKey;
    String? sessionToken = awsCredentials.credentialsResult.value.sessionToken;
    String? identityId = awsCredentials.identityIdResult.value;
    username = awsCredentials.userSubResult.value;
    // print('identityId: $username');
    mqttConnect(accessKey, secretKey, sessionToken!, identityId, username);
  }

  disconnect() {
    client.disconnect();
    ref.read(mqttStatusNotifier.notifier).state = false;
  }

  getCurrentData(String device) {
    final builder = MqttClientPayloadBuilder();
    builder.addString('{"message" : "currentdata"}');
    client.publishMessage(
        '$username/$device/currentdata', MqttQos.atMostOnce, builder.payload!);
  }

  getAllDeviceData(List<Device?> devices) {
    for (var device in devices) {
      getCurrentData(device!.serialNumber);
    }
  }

  Future mqttConnect(String accessKey, String secretKey, String sessionToken,
      String identityId, String username) async {
    // Your AWS region
    const region = 'us-east-2';
    // Your AWS IoT Core endpoint url
    const baseUrl = 'a2k4uqgawrkgp2-ats.iot.$region.amazonaws.com';
    const scheme = 'wss://';
    const urlPath = '/mqtt';
    // AWS IoT MQTT default port for websockets
    const port = 443;

    // The necessary AWS credentials to make a connection.
    // Obtaining them is not part of this example, but you can get the below credentials via any cognito/amplify library like amazon_cognito_identity_dart_2 or amplify_auth_cognito.
    // String accessKey = '<aws-access-key>';
    // String secretKey = '<aws-secret-key>';
    // String sessionToken = '<aws-session-token>';
    // String identityId = '<identity-id>';

    // Transform the url into a Websocket url using SigV4 signing
    String signedUrl = getWebSocketURL(
        accessKey: accessKey,
        secretKey: secretKey,
        sessionToken: sessionToken,
        region: region,
        scheme: scheme,
        endpoint: baseUrl,
        urlPath: urlPath);

    // Create the client with the signed url
    client = MqttServerClient.withPort(signedUrl, username, port,
        maxConnectionAttempts: 1);

    // Set the protocol to V3.1.1 for AWS IoT Core, if you fail to do this you will not receive a connect ack with the response code
    client.setProtocolV311();
    // logging if you wish
    client.logging(on: true);
    client.useWebSocket = true;
    client.secure = false;
    client.autoReconnect = false;
    client.disconnectOnNoResponsePeriod = 90;
    client.keepAlivePeriod = 30;

    final MqttConnectMessage connMess =
        MqttConnectMessage().withClientIdentifier(username);

    client.connectionMessage = connMess;

    // Connect the client
    try {
      print('MQTT client connecting to AWS IoT using cognito....');
      await client.connect();
    } on Exception catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
    }
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');
      ref.read(mqttStatusNotifier.notifier).state = true;

      // Publish to a topic of your choice
      final topic = '$username/+/+';
      // final builder = MqttClientPayloadBuilder();
      // builder.addString('Hello World');
      // // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
      // client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

      // Subscribe to the same topic
      client.subscribe(topic, MqttQos.atLeastOnce);
      // Print incoming messages from another client on this topic
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');

        // prase payload to json
        // List json = ref.read(devicesLevelData);

        // json[c[0].topic.split('/')[1]] =
        //     jsonDecode(pt)['levelSensor']['Height'];

        ref.read(devicesLevelData.notifier).update((state) {
          final newMap = {...state};
          final d = DateTime.now();

          newMap[c[0].topic.split('/')[1]] = [
            jsonDecode(pt)['levelSensor']['Height'],
            '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}'
          ];

          return newMap;
        });
        print('devicesLevelData: ${ref.read(devicesLevelData)}');
        //update state provider to trigger rebuild widget
      });
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
      ref.read(mqttStatusNotifier.notifier).state = false;
    }

    print('Sleeping....');
    await MqttUtilities.asyncSleep(10);

    // print('Disconnecting');
    // client.disconnect();
    // ref.read(mqttStatusNotifier.notifier).state = false;
  }

  Future fetchCognitoAuthSession() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final identityId = result.identityIdResult.value;
      safePrint("Current user's identity ID: $identityId");
      return result;
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
  }
}
