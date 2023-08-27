/*
 * Package : mqtt_client
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 21/04/2022
 * Copyright :  S.Hamblett
 *
 */

import 'package:sigv4/sigv4.dart';

/// An example of connecting to the AWS IoT Core MQTT broker and publishing to a devices topic.
/// This example uses MQTT over Websockets with AWS IAM Credentials
/// This is a proven working example, but it requires some preparation. You will need to get Cognito credentials from somewhere, and your IAM policies set up properly.
/// The first two functions are helpers, please look at the main() for the client setup
/// More instructions can be found at https://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html and
/// https://docs.aws.amazon.com/iot/latest/developerguide/protocols.html, please read this
/// before setting up and running this example.

// This function is based on the one from package flutter-aws-iot, but adapted slightly
String getWebSocketURL(
    {required String accessKey,
    required String secretKey,
    required String sessionToken,
    required String region,
    required String scheme,
    required String endpoint,
    required String urlPath}) {
  const serviceName = 'iotdevicegateway';
  const awsS4Request = 'aws4_request';
  const aws4HmacSha256 = 'AWS4-HMAC-SHA256';
  var now = Sigv4.generateDatetime();

  var creds = [
    accessKey,
    now.substring(0, 8),
    region,
    serviceName,
    awsS4Request,
  ];

  var queryParams = {
    'X-Amz-Algorithm': aws4HmacSha256,
    'X-Amz-Credential': creds.join('/'),
    'X-Amz-Date': now,
    'X-Amz-SignedHeaders': 'host',
  };

  var canonicalQueryString = Sigv4.buildCanonicalQueryString(queryParams);

  var request = Sigv4.buildCanonicalRequest(
    'GET',
    urlPath,
    queryParams,
    {'host': endpoint},
    '',
  );

  var hashedCanonicalRequest = Sigv4.hashPayload(request);
  var stringToSign = Sigv4.buildStringToSign(
    now,
    Sigv4.buildCredentialScope(now, region, serviceName),
    hashedCanonicalRequest,
  );

  var signingKey = Sigv4.calculateSigningKey(
    secretKey,
    now,
    region,
    serviceName,
  );

  var signature = Sigv4.calculateSignature(signingKey, stringToSign);

  var finalParams =
      '$canonicalQueryString&X-Amz-Signature=$signature&X-Amz-Security-Token=${Uri.encodeComponent(sessionToken)}';

  return '$scheme$endpoint$urlPath?$finalParams';
}
