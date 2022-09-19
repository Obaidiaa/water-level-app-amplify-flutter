import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wifi_scan/wifi_scan.dart';

final wiFiServicesProvider = Provider((ref) => WiFiServices());

final getWiFiAcces = FutureProvider((ref) {
  final wiFiServices = ref.watch(wiFiServicesProvider);
  return wiFiServices.scan();
});

class WiFiServices extends StateNotifier {
  WiFiServices() : super(null);

  Map<String, dynamic> wifiAccesPointCredentials = {
    'ssid': '',
    'pass': '',
  };

  Future<List<WiFiAccessPoint>?> scan() async {
    if (await WiFiScan.instance.hasCapability()) {
      // start full scan async-ly
      final error = await WiFiScan.instance.startScan(askPermissions: true);
      if (error != null) {
        switch (error) {
          // handle error for values of StartScanErrors
          case StartScanErrors.notSupported:
            // TODO: Handle this case.
            break;
          case StartScanErrors.noLocationPermissionRequired:
            // TODO: Handle this case.
            break;
          case StartScanErrors.noLocationPermissionDenied:
            // TODO: Handle this case.
            break;
          case StartScanErrors.noLocationPermissionUpgradeAccuracy:
            // TODO: Handle this case.
            break;
          case StartScanErrors.noLocationServiceDisabled:
            // TODO: Handle this case.
            break;
          case StartScanErrors.failed:
            // TODO: Handle this case.
            break;
        }
      }
      // get scanned results
      final result =
          await WiFiScan.instance.getScannedResults(askPermissions: true);
      if (result.hasError) {
        switch ('error') {
          // handle error for values of GetScannedResultErrors
        }
      } else {
        final accessPoints = result.value;
        return accessPoints;
      }
    } else {
      // fallback mechanism, like - show user that "scan" is not possible
    }
    return null;
  }
}
