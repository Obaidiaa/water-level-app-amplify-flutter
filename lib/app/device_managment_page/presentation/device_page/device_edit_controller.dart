import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';

part 'device_edit_controller.g.dart';

@riverpod
class DeviceEditController extends _$DeviceEditController {
  @override
  FutureOr<void> build() {
    //
  }

  Future<bool> declaimDevice(String serialNumber) async {
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
