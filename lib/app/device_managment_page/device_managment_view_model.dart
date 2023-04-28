import 'dart:async';

import 'package:amplify_api/model_subscriptions.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/models/Device.dart';
import 'package:water_level_flutter/services/datastore_services.dart';
import 'package:water_level_flutter/services/device_managment_services.dart';
import 'package:water_level_flutter/services/graphql_services.dart';

final deviceManagementViewModelProvider =
    StateNotifierProvider<DeviceManagementViewModel, AsyncValue<List<Device?>>>(
        (ref) {
  return DeviceManagementViewModel(ref);
});

// final getDevicesProvider = FutureProvider<List<Device>>((ref) async {
//   ref.watch(deviceManagementViewModelProvider);
//   print('refefefefefefe');
//   return await Amplify.DataStore.query(Device.classType);
// });

final claimDeviceProvider =
    FutureProvider.family<AsyncValue, String>((ref, id) async {
  return ref.watch(deviceManagementViewModelProvider.notifier).claimDevice(id);
});

final deviceListProvider = StreamProvider((ref) {
  return ref.watch(graphqlServices).subscribe();
});

class DeviceManagementViewModel
    extends StateNotifier<AsyncValue<List<Device?>>> {
  DeviceManagementViewModel(this.ref) : super(AsyncLoading()) {
    _init();
  }

  Ref ref;
  void _init() async {
    getDevices();
    ref.watch(graphqlServices).subscribe().listen((event) async {
      print(event);
      getDevices();
    });
  }

  getDevices() async {
    state = const AsyncLoading();
    AsyncValue<List<Device?>> deviceList =
        await ref.read(deviceManagementServicesProvider).getDevices();
    state = deviceList;
  }

  claimDevice(String id) {
    // AsyncValue d =
    state = const AsyncLoading();
    return ref.read(deviceManagementServicesProvider).claimDevice(id);
    // d.when(
    //     data: (data) => getDevices(),
    //     error: (error, stackTrace) => print(error.toString()),
    //     loading: () => print("loding"));
  }
}
