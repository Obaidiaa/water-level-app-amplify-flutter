// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/models/ModelProvider.dart';
// import 'package:water_level_flutter/services/auth_services.dart';
// import 'package:water_level_flutter/services/device_managment_services.dart';

// final deviceManagementServicesNotifier = StateNotifierProvider<
//     DeviceManagementServicesNotifier, AsyncValue<List<Device>>>((ref) {
//   return DeviceManagementServicesNotifier(ref);
// });

// class DeviceManagementServicesNotifier
//     extends StateNotifier<AsyncValue<List<Device>>> {
//   DeviceManagementServicesNotifier(this.ref) : super(AsyncData([])) {
//     _init();
//   }

//   void _init() async {
//     state = const AsyncLoading();
//     List<Device> deviceList =
//         await ref.read(deviceManagementServicesProvider).getDevices();
//     state = AsyncData(deviceList);
//   }

//   Ref ref;

//   void add() async {
//     await ref.read(deviceManagementServicesProvider).addDevice(
//         1, 1, 1, 1, "", "DeviceType.WATER_LEVEL_SENSOR", 'ThingName');
//     _init();
//   }

//   listenChanges() {
//     Amplify.DataStore.observe(Device.classType).listen(
//       (event) {
//         _init();
//         if (kDebugMode) {
//           print('Received event of type ${event.eventType}');
//           print('Received post ${event.item}');
//         }
//       },
//     );
//   }
// }
