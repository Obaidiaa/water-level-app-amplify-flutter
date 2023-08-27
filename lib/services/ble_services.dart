// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:water_level_flutter/app/device_setup/device_setup_viewmodel.dart';
// import 'package:water_level_flutter/services/wifi_services.dart';

// final bleServicesProvider = Provider(((ref) => BLEServices(ref)));

// // final bleDeviceConnectionStatusProvider = FutureProvider(((ref) {
// //   final bleService = ref.watch(bleServicesProvider);
// //   return bleService.bleDeviceConnectionStatus();
// // }));

// final bleStateProvider = StateProvider<String>((ref) {
//   return '';
// });

// // final deviceResponseProvider = StreamProvider<List<int>>((ref) {
// //   final bleService = ref.watch(bleServicesProvider);
// //   return bleService.controller;
// // });
// final bleConnectionStatus = StateProvider<bool>((ref) {
//   return false;
// });

// final wiFicredentialReceived = StateProvider<bool>((ref) {
//   return false;
// });

// class BLEServices extends StateNotifier {
//   BLEServices(this.ref) : super(null);

//   final serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
//   final characteristicUuid = "beb5483e-36e1-4688-b7f5-ea07361b26a8";

//   // final service_uuid2 = "4fafc201-1fb5-459e-8fcc-c5c9c331915a";
//   // final characteristic_uuid2 = "beb5483e-36e1-4688-b7f5-ea07361b26b8";

//   final String TARGET_DEVICE_NAME = "Water";

//   FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
//   StreamSubscription<ScanResult>? scanSubscription;

//   final Ref ref;

//   BluetoothDevice? bluetoothDevice;
//   BluetoothCharacteristic? wiFibluetoothCharacteristic;

//   startScan() {
//     ref.watch(bleStateProvider.notifier).state = "Start Scanning";

//     scanSubscription = flutterBlue.scan().listen((scanResult) {
//       if (scanResult.device.name.contains(TARGET_DEVICE_NAME)) {
//         stopScan();

//         ref.watch(bleStateProvider.notifier).state = "Found Target Device";

//         bluetoothDevice = scanResult.device;
//         connectToDevice();
//       }
//     }, onDone: () => stopScan());
//   }

//   connectToDevice() async {
//     if (bluetoothDevice == null) {
//       return;
//     }

//     ref.watch(bleStateProvider.notifier).state = "Device Connecting";

//     await bluetoothDevice?.connect().catchError((err) => print(err));

//     ref.watch(bleConnectionStatus.notifier).state = true;
//     ref.watch(bleStateProvider.notifier).state = "Device Connected";

//     discoverServices();
//   }

//   stopScan() {
//     scanSubscription?.cancel();
//     flutterBlue.stopScan();
//     scanSubscription = null;
//   }

//   disconnectFromDeivce() {
//     if (bluetoothDevice == null) {
//       return;
//     }

//     bluetoothDevice?.disconnect();

//     ref.watch(bleStateProvider.notifier).state = "Device Disconnected";
//   }

//   discoverServices() async {
//     if (bluetoothDevice == null) {
//       return;
//     }

//     List<BluetoothService>? services =
//         await bluetoothDevice?.discoverServices();
//     services?.forEach((service) {
//       if (service.uuid.toString() == serviceUuid) {
//         service.characteristics.forEach((characteristics) {
//           if (characteristics.uuid.toString() == characteristicUuid) {
//             wiFibluetoothCharacteristic = characteristics;

//             ref.watch(bleStateProvider.notifier).state =
//                 "Connected ${bluetoothDevice?.name}";
//           }
//         });
//       }
//     });
//   }

//   writeData() async {
//     if (wiFibluetoothCharacteristic == null) return;

//     final wiFiCredential =
//         '${ref.watch(wiFiServicesProvider).wifiAccesPointCredentials['ssid']},${ref.watch(wiFiServicesProvider).wifiAccesPointCredentials['pass']}';
//     List<int> bytes = utf8.encode(wiFiCredential);
//     await wiFibluetoothCharacteristic?.write(bytes);
//     ref.watch(wiFicredentialReceived.notifier).state = false;
//     readData();
//   }

//   readData() {
//     if (wiFibluetoothCharacteristic == null) return;
//     wiFibluetoothCharacteristic?.setNotifyValue(true);
//     wiFibluetoothCharacteristic?.value.listen((event) {
//       final data = String.fromCharCodes(event);

//       if (data.contains('200')) {
//         ref.watch(wiFicredentialReceived.notifier).state = true;
//       }
//       Future.delayed(const Duration(seconds: 5),
//           (() => ref.watch(wiFicredentialReceived.notifier).state = false));
//     });
//   }

//   // StreamController<List<int>> wiFiCredenitalsReceived =
//   //     StreamController<List<int>>();
//   // StreamController<List<int>> liveData = StreamController<List<int>>();

// //   deviceResponse() {
// //     print(bluetoothDevice?.name);
// //     bluetoothDevice!.discoverServices().then((value) => {
// //           // print(bluetoothDevice!.services.map((event) => event.map((e) => e)));

// //           bluetoothDevice?.services.listen((event) {
// //             final service = event.firstWhere(
// //                 ((element) => element.uuid.toString() == service_uuid));

// //             print(
// //                 'ddddddddddddddddddddddd ${service.characteristics.map((e) => e.uuid)}');
// //             final characteristic = service.characteristics.firstWhere(
// //                 (element) => element.uuid.toString() == characteristic_uuid);
// //             // final characteristic2 = service.characteristics.firstWhere(
// //             //     (element) => element.uuid.toString() == characteristic_uuid2);

// //             // characteristic2.setNotifyValue(true);
// //             // characteristic2.value.listen((event) {
// //             //   print(event);
// //             //   liveData.add(event);
// //             // });
// //             wiFibluetoothCharacteristic = characteristic;
// //             characteristic.setNotifyValue(true);
// //             characteristic.value.listen((event) {
// //               print(event);
// //               // wiFiCredenitalsReceived.add(event);
// //               if (String.fromCharCodes(event).contains('200')) {
// //                 print(
// //                     "ssssssssssssss ${String.fromCharCodes(event).contains('200')}");
// //                 ref
// //                     .watch(wiFicredentialReceived.notifier)
// //                     .update((state) => state = true);
// //               }
// //             });
// //             // return characteristic.value;
// //           })
// //         });
// //   }

// //   bleConnect(device) async {
// // // Connect to the device
// //     await device.connect();
// //   }

// //   bleDisconnect() async {
// // // Connect to the device
// //     await bluetoothDevice?.disconnect();
// //   }

// //   bleSendWiFiCredentials() async {
// //     ref.watch(wiFicredentialReceived.notifier).update((state) => state = false);
// //     // List<int> list = json.decode('{home:matrix}').cast<int>();
// //     // print(list);
// //     // bluetoothDevice!.discoverServices().then((value) => {
// //     //       bluetoothDevice!.services
// //     //           .listen((List<BluetoothService> services) async {
// //     //         final service = services
// //     //             .where((element) => element.uuid.toString() == service_uuid);
// //     //         final characteristic = service.first.characteristics.where(
// //     //             (element) => element.uuid.toString() == characteristic_uuid);
// //     //         final d = await characteristic.first.read();
// //     //         print(String.fromCharCodes(d));
// //     //         if (String.fromCharCodes(d).contains('200')) {
// //     //           print(
// //     //               "ssssssssssssss ${String.fromCharCodes(d).contains('200')}");
// //     //           ref
// //     //               .watch(wiFicredentialReceived.notifier)
// //     //               .update((state) => state = true);
// //     //         } else {
// //     //           ref
// //     //               .watch(wiFicredentialReceived.notifier)
// //     //               .update((state) => state = false);
// //     //         }
// //     //         // [72, 105, 103, 104, 32, 82, 101, 97, 108, 108, 121]
// //     //         print(
// //     //             '${ref.watch(deviceSetupViewModelProvider).wifiAccesPointCredentials['ssid']},${ref.watch(deviceSetupViewModelProvider).wifiAccesPointCredentials['pass']}');
// //     wiFibluetoothCharacteristic?.write(
// //         '${ref.watch(deviceSetupViewModelProvider).wifiAccesPointCredentials['ssid']},${ref.watch(deviceSetupViewModelProvider).wifiAccesPointCredentials['pass']}'
// //             .runes
// //             .toList());
// //     // })
// //     // });
// //   }
// }
