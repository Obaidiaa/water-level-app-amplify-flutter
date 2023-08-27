import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/services/mqtt_services.dart';

part 'home_page_controller.g.dart';

@riverpod
class HomePageController extends _$HomePageController {
  @override
  FutureOr<void> build() {
    //
    // getDevices();
  }

  initMQTT() {
    ref.read(mqttServicesProvider).init();
    var period = const Duration(seconds: 60);
    Timer.periodic(period, (arg) {
      // refreshData();
    });
  }

  refreshData() async {
    final devices = await ref.read(devicesListFutureProvider.future);
    ref.read(mqttServicesProvider).getAllDeviceData(devices);
  }

  // Future<bool> getDevices() async {
  //   state = const AsyncLoading();
  //   final devicesList = ref.read(devicesListFutureProvider);
  //   state = AsyncValue.guard(() => devicesList);
  //   print(state);
  //   return state.hasError == false;
  // }
}
