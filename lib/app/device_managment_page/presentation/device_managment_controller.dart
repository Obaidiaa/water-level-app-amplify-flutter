import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';

part 'device_managment_controller.g.dart';

@riverpod
class DeviceManagmentController extends _$DeviceManagmentController {
  // Add your state and logic here
  @override
  FutureOr<void> build() async {
    print('build');
  }

  Future<bool> claimDevice(String id) async {
    state = const AsyncLoading();
    final repository = ref.read(devicesRepositoryProvider);
    state = await AsyncValue.guard(() => repository.claimDevice(id));

    return state.hasError == false;
  }
}
