import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:water_level_flutter/packages/mqtt_aws_iot.dart';

final mqttServicesProvider = Provider<MqttServices>((ref) {
  return MqttServices(ref);
});

final mqttStatusNotifier = StateProvider<bool?>((ref) => false);

class MqttServices {
  // MqttServices(this.ref);
  Ref ref;
  MqttServices(this.ref) {
    init();
  }

  init() async {
    CognitoAuthSession awsCredentials = await _fetchSession();
    String? accessKey = awsCredentials.credentials!.awsAccessKey;
    String? secretKey = awsCredentials.credentials!.awsSecretKey;
    String? sessionToken = awsCredentials.credentials!.sessionToken;
    String? identityId = awsCredentials.identityId;
    String? username = awsCredentials.userSub;
    mqttConnect(accessKey!, secretKey!, sessionToken!, identityId!, username!);
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
    MqttServerClient client = MqttServerClient.withPort(
        signedUrl, identityId, port,
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
        MqttConnectMessage().withClientIdentifier(identityId);

    client.connectionMessage = connMess;

    // Connect the client
    try {
      print('MQTT client connecting to AWS IoT using cognito....');
      await client.connect();
    } on Exception catch (e) {
      print('MQTT client exception - $e');
      client.disconnect();
    }
    ref.read(mqttStatusNotifier.notifier).state = true;
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');

      // Publish to a topic of your choice
      final topic = '$identityId/topic';
      final builder = MqttClientPayloadBuilder();
      builder.addString('Hello World');
      // Important: AWS IoT Core can only handle QOS of 0 or 1. QOS 2 (exactlyOnce) will fail!
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);

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
      });
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
      ref.read(mqttStatusNotifier.notifier).state = false;
    }

    print('Sleeping....');
    await MqttUtilities.asyncSleep(10);

    print('Disconnecting');
    client.disconnect();
    ref.read(mqttStatusNotifier.notifier).state = false;
  }

  static Future _fetchSession() async {
    try {
      AuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );

      String identityId = (res as CognitoAuthSession).identityId!;

      print('identityId: $identityId');
      print('UserSub: ${res.userSub}');
      try {
        AuthUser res = await Amplify.Auth.getCurrentUser();
        print('UserSub: ${res.username}');
        // currentUser = res.username;
      } on AuthException catch (e) {
        print(e.message);
      }
      return res;
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
