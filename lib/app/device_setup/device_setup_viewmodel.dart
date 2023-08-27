import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_scan/wifi_scan.dart';

const SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
const CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
const TARGET_DEVICE_NAME = 'Water Level';

final deviceSetupViewModelProvider = Provider((ref) => DeviceSetupViewModel());

class DeviceSetupViewModel extends StateNotifier {
  DeviceSetupViewModel() : super(null);

  WiFiAccessPoint? _accessPoint;

  WiFiAccessPoint? get accessPoint => _accessPoint;

  set accessPoint(WiFiAccessPoint? accessPoint) {
    _accessPoint = accessPoint;
    print(_accessPoint!.ssid);
  }
}
