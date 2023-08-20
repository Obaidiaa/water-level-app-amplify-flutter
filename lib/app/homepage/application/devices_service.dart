import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_page/device_edit_controller.dart';

part 'devices_service.g.dart';

class DevicesService {
  DevicesService({required this.devicesRepository});

  final DevicesRepository devicesRepository;

  Future<List<Device?>> devicesList() {
    return devicesRepository.getDevices();
  }
}

@riverpod
DevicesService devicesService(DevicesServiceRef ref) {
  ref.watch(deviceEditControllerProvider);
  return DevicesService(
    devicesRepository: ref.watch(devicesRepositoryProvider),
  );
}

@riverpod
Future<List<Device?>> devicesListFuture(DevicesListFutureRef ref) {
  final devicesService = ref.watch(devicesServiceProvider);
  print('devicesListFuture called from devices_service.dart');
  return devicesService.devicesList();
}
