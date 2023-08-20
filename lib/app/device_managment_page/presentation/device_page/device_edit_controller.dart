// import 'dart:ffi';

// import 'package:amplify_api/amplify_api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
// import 'package:water_level_flutter/models/Device.dart';
// import 'package:water_level_flutter/services/device_managment_services.dart';
// import 'package:water_level_flutter/services/graphql_services.dart';

// final deviceEditPageViewModelProvider =
//     StateNotifierProvider.family<DevicePageViewModelNotifier, Device, Device>(
//         (ref, device) {
//   return DevicePageViewModelNotifier(device, ref);
// });

// final deleteDeviceProvider =
//     FutureProvider.family<AsyncValue, Device>((ref, device) async {
//   final d = await ref.watch(graphqlServices).deleteDevice(device.serialNumber);
//   return d;
// });

// class DevicePageViewModelNotifier extends StateNotifier<Device> {
//   final thingNameController = TextEditingController();
//   final heightController = TextEditingController();
//   final highLevelAlarmController = TextEditingController();
//   final lowLevelAlarmController = TextEditingController();
//   bool notification = false;

//   Ref ref;
//   DevicePageViewModelNotifier(super.state, this.ref) {
//     thingNameController.text = state.thingName ?? "";
//     heightController.text =
//         state.height == null ? '10' : state.height.toString();
//     highLevelAlarmController.text =
//         state.highLevelAlarm == null ? '5' : state.highLevelAlarm.toString();
//     lowLevelAlarmController.text =
//         state.lowLevelAlarm == null ? '0' : state.lowLevelAlarm.toString();
//     // print(lowLevelAlarmController.text);
//     notification = state.notification ?? false;
//   }

//   Future<AsyncValue> onDelete(BuildContext context) async {
//     final d = await ref.read(graphqlServices).deleteDevice(state.serialNumber);
//     return d;
//     // d.when(
//     //     data: (data) {
//     //       ref.refresh(deviceManagementViewModelProvider);
//     //       Navigator.of(context).pop();
//     //     },
//     //     error: (error, stackTrace) {
//     //       final err = error as List<GraphQLResponseError>;
//     //       // String errorMessage = "";
//     //       // if (err.first.extensions!["errorType"] ==
//     //       //     "DynamoDB:ConditionalCheckFailedException") {
//     //       //   errorMessage = "device not found";
//     //       // }
//     //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     //         content: Text(err.first.message),
//     //         backgroundColor: Colors.red,
//     //       ));
//     //     },
//     //     loading: () => print("loding"));
//   }

//   void onUpdate() {}

//   void onChange(bool value) {
//     state = state.copyWith(notification: value);
//     // print(state);
//   }

//   void save(BuildContext context) async {
//     state = state.copyWith(
//       thingName: thingNameController.text,
//       height: int.parse(heightController.text),
//       highLevelAlarm: int.parse(highLevelAlarmController.text),
//       lowLevelAlarm: int.parse(lowLevelAlarmController.text),
//       notification: notification,
//     );
//     final response =
//         await ref.read(deviceManagementServicesProvider).updateDevice(state);

//     response.when(
//         data: (data) {
//           // ref.refresh(deviceManagementViewModelProvider);
//           ref.read(deviceManagementViewModelProvider.notifier).getDevices();
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text("Update Done")));
//         },
//         error: (error, stackTrace) =>
//             print("eeeeeeeeeeeeeeeerrv ${error.toString()}"),
//         loading: () => print("loding"));
//   }
// }

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';

part 'device_edit_controller.g.dart';

@riverpod
class DeviceEditController extends _$DeviceEditController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<bool> declaimDevice(String serialNumber) async {
    // final currentUser = ref.read(authRepositoryProvider).currentUser;
    // if (currentUser!.uid != announcement.authorId) {
    //   throw AssertionError('User can\'t be null');
    // }
    final repository = ref.read(devicesRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.declaimDevice(
          serialNumber,
        ));

    return state.hasError == false;
  }

  Future<bool> updateDevice(
    String serialNumber,
    String thingName,
    int height,
    int highLevelAlarm,
    int lowLevelAlarm,
    bool notification,
    String location,
  ) async {
    final repository = ref.read(devicesRepositoryProvider);
    state = const AsyncLoading();
    // device.

    state = await AsyncValue.guard(() => repository.updateDevice(
          serialNumber,
          thingName,
          height,
          highLevelAlarm,
          lowLevelAlarm,
          notification,
          location,
        ));

    return state.hasError == false;
  }
}
