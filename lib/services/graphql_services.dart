import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/models/ModelProvider.dart';

final graphqlServices = Provider<GraphqlServices>((ref) {
  return GraphqlServices(ref);
});

class GraphqlServices {
  GraphqlServices(ProviderRef<GraphqlServices> ref);
  Ref? ref;

  Stream<GraphQLResponse<Device>> subscribe() {
    final subscriptionRequest = ModelSubscriptions.onUpdate(Device.classType);
    final Stream<GraphQLResponse<Device>> operation = Amplify.API
        .subscribe(
      subscriptionRequest,
      onEstablished: () => print('Subscription established'),
    )
        .handleError(
      (error) {
        print('Error in subscription stream: $error');
      },
    );
    return operation;
  }

  Future<AsyncValue<List<Device?>>> getDevices() async {
    try {
      final request = ModelQueries.list(Device.classType);
      final response = await Amplify.API.query(request: request).response;
      final deviceList = response.data;
      if (deviceList == null) {
        return AsyncError('errors: ${response.errors}', StackTrace.empty);
      }
      return AsyncData(deviceList.items);
    } on ApiException catch (e) {
      print('Query failed: $e');
      return AsyncError(e, StackTrace.empty);
    }
  }

  Future<AsyncValue> claimDevice(String id) async {
    const thingOwnerManager = 'ThingOwnerManager';
    String graphQLDocument = '''query ThingOwnerManager {
  $thingOwnerManager(serialNumber: "$id", action: "claim") {
          status
    message
    action
    serialNumber
    owner
  }
}''';
    final request = GraphQLRequest<ThingOwnerManagerRes>(
      document: graphQLDocument,
      modelType: ThingOwnerManagerRes.classType,
      decodePath: thingOwnerManager,
    );
    print(" ididididdididi ${id}");
    return query(request);
  }

  Future<AsyncValue> attachPolicy(String id) async {
    final AuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true));

    const attachPolicyToUser = 'AttachPolicyToUser';
    String graphQLDocument = '''query AttachPolicyToUser {
  $attachPolicyToUser(username: "${(res as CognitoAuthSession).userPoolTokens!.idToken}") {
    status
    message
  }
}''';
    final request = GraphQLRequest<ThingOwnerManagerRes>(
      document: graphQLDocument,
      modelType: ThingOwnerManagerRes.classType,
      decodePath: attachPolicyToUser,
    );
    print(" attach user to policy");
    return query(request);
  }

  Future<AsyncValue> updateDevice(Device device) async {
    // final queryPredicate = Device.SERIALNUMBER.eq(device.serialNumber);
    // final readRequest =
    //     ModelQueries.list(Device.classType, where: queryPredicate);
    // final readResponse = await Amplify.API.query(request: readRequest).response;
    // final result = readResponse.data;
    // if (result == null) {
    //   return AsyncError(
    //       'read errors: ${readResponse.errors}', StackTrace.empty);
    // }
    // print("wwwwwwwwwwwwwwwwwwwww ${result.items.first}");
    const updateDevice = 'updateDevice';
    String graphQLDocument = '''mutation updateDevice {
  $updateDevice(input: {serialNumber: "${device.serialNumber}", thingName: "${device.thingName}", height:${device.height} ,
   highLevelAlarm:${device.highLevelAlarm}, lowLevelAlarm:${device.lowLevelAlarm},
   notification:${device.notification},location:"${device.location}"}) {
      owner
      serialNumber
      active
      certificate
      createdAt
      highLevelAlarm
      height
      lat
      lng
      location
      lowLevelAlarm
      notification
      ownerCounter
      thingName
      type
      updatedAt
  }
}''';
    final request = GraphQLRequest<Device>(
      document: graphQLDocument,
      modelType: Device.classType,
      decodePath: updateDevice,
    );
    return query(request);
  }

  Future<AsyncValue> deleteDevice(String id) async {
    const thingOwnerManager = 'ThingOwnerManager';
    String graphQLDocument = '''query ThingOwnerManager {
  $thingOwnerManager(serialNumber: "$id", action: "declaim") {
          status
    message
    action
    serialNumber
    owner
  }
}''';
    final request = GraphQLRequest<ThingOwnerManagerRes>(
      document: graphQLDocument,
      modelType: ThingOwnerManagerRes.classType,
      decodePath: thingOwnerManager,
    );
    print(" ididididdididi ${id}");
    return query(request);
  }

  Future<AsyncValue> query(GraphQLRequest request) async {
    try {
      final response = await Amplify.API.query(request: request).response;
      print('Response: data : ${response.data}  error :${response.errors}');
      if (response.errors.isNotEmpty) {
        return AsyncError(response.errors, StackTrace.empty);
      }
      // if (response.data?.status != 200) {
      //   return AsyncError(response.data.message, StackTrace.empty);
      // }
      return AsyncData(response.data);
    } catch (e) {
      return AsyncError(e, StackTrace.empty);
    }

    // if (response.data == null) {}
  }
}
