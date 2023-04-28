import 'package:amplify_api/model_mutations.dart';
import 'package:amplify_api/model_queries.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_view_model.dart';
import 'package:water_level_flutter/models/Device.dart';
import 'package:water_level_flutter/models/DeviceType.dart';
import 'package:water_level_flutter/models/ModelProvider.dart';
import 'package:water_level_flutter/services/auth_services.dart';
import 'package:water_level_flutter/services/device_management_notifier.dart';
import 'package:water_level_flutter/services/graphql_services.dart';

final deviceManagementServicesProvider =
    Provider<DeviceManagementServices>((ref) {
  return DeviceManagementServices(ref);
});

// final claimDeviceProvider =
//     FutureProvider.family<AsyncValue, String>((ref, id) async {
//   return ref.read(deviceManagementServicesProvider.notifier).claimDevice(id);
// });

class DeviceManagementServices {
  DeviceManagementServices(this.ref);

  Ref ref;
  Future addDevice(
    int? lowLevelAlarm,
    int? highLevelA,
    double? lat,
    double? lng,
    String? location,
    String? type,
    String? thingName,
  ) async {
    try {
      ref.read(authServicesProvider).getCurrentUser().then((value) async {
        final newPost = Device(
          // userID: value.userId,
          serialNumber: "008",
          thingName: thingName,
          lowLevelAlarm: lowLevelAlarm,
          highLevelAlarm: highLevelA,
          lat: lat,
          lng: lng,
          location: location,
          type: DeviceType.WATER_LEVEL_SENSOR,
          owner: value.userId,
        );
        await Amplify.DataStore.save(newPost);
      });
    } catch (e) {
      print("Error adding device $e");
    }
  }

  Future<AsyncValue> updateDevice(Device device) async {
    final d = await ref.read(graphqlServices).updateDevice(device);
    return d;
    // d.when(
    //     data: (data) {
    //       // ref.refresh(deviceManagementViewModelProvider);
    //     },
    //     error: (error, stackTrace) =>
    //         print("eeeeeeeeeeeeeeeerrv ${error.toString()}"),
    //     loading: () => print("loding"));
  }

  Future<AsyncValue> claimDevice(String id) {
    return ref.read(graphqlServices).claimDevice(id);
    // d.when(
    //     data: (data) {
    //       ref.read(deviceManagementViewModelProvider.notifier).getDevices();
    //       Navigator.of(context).pop();
    //     },
    //     error: (error, stackTrace) => print(error.toString()),
    //     loading: () => print("loding"));
  }

  deleteDevice(String id) async {
    // return ref.read(graphqlServices).deleteDevice(id);
    final d = await ref.read(graphqlServices).deleteDevice(id);
    d.when(
        data: (data) {
          ref.refresh(deviceManagementViewModelProvider);
          // Navigator.of(context).pop();
        },
        error: (error, stackTrace) => print(error.toString()),
        loading: () => print("loding"));
  }

  Future<AsyncValue<List<Device?>>> getDevices() async {
    return ref.read(graphqlServices).getDevices();
  }
}
