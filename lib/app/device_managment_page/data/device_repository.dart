import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/models/ThingOwnerManagerRes.dart';

part 'device_repository.g.dart';

class DevicesRepository {
  Future<List<Device?>> getDevices() async {
    try {
      final request = ModelQueries.list(Device.classType);
      final response = await Amplify.API.query(request: request).response;
      final deviceList = response.data;
      print('Response: data : ${response.data}  error :${response.errors}');
      if (deviceList == null) {
        throw ('errors: ${response.errors}');
      }
      return deviceList.items;
    } on ApiException catch (e) {
      print('Query failed: $e');
      rethrow;
    }
  }

  Future claimDevice(String id) async {
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

  query(GraphQLRequest request) async {
    try {
      final response = await Amplify.API.query(request: request).response;
      print('Response: data : ${response.data}  error :${response.errors}');
      if (response.errors.isNotEmpty) {
        throw response.errors.first.message;
      }
      // if (response.data?.status != 200) {
      //   return AsyncError(response.data.message, StackTrace.empty);
      // }
      return response.data;
    } catch (e) {
      rethrow;
    }
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
}

@Riverpod(keepAlive: true)
DevicesRepository devicesRepository(DevicesRepositoryRef ref) {
  return DevicesRepository();
}
