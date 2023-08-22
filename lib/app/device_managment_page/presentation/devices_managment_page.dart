import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_managment_controller.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/app/util/async_value_ui.dart';
import 'package:water_level_flutter/routing/app_router.dart';

// import 'package:flutter_zxing/flutter_zxing.dart';

// import './domain/Device.dart';

class DevicesManagmentPage extends ConsumerStatefulWidget {
  const DevicesManagmentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DevicesManagmentPageState();
}

class _DevicesManagmentPageState extends ConsumerState<DevicesManagmentPage> {
  @override
  Widget build(BuildContext context) {
    // ref.watch(deviceManagementViewModelProvider);
    final state = ref.watch(devicesListFutureProvider);
    ref.listen<AsyncValue>(
      deviceManagmentControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 7,
                  offset: const Offset(0, 0.75), // changes position of shadow
                ),
              ],
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 100 * 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(),
                  Row(
                    children: const [
                      Icon(Icons.device_hub, size: 35),
                      Text(
                        'Devices',
                        style: TextStyle(fontSize: 35),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      child: const Icon(Icons.add, size: 40),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (contextd) => const AddDeviceDialog());
                        // ref
                        // .read(deviceManagmentControllerProvider.notifier)
                        // .claimDevice('010');
                        // ref.read(isloadingPro.notifier).state = true;
                        // await _scanQRCode();
                        //
                        // final d = await ref
                        //     .watch(deviceManagementServicesProvider)
                        //     .claimDevice(_qrCodeResult);
                        //
                        // d.when(
                        //     data: (data) {
                        //       print(data);
                        //       // ref.read(isloadingPro.notifier).state = false;
                        //       // ref
                        //       //     .read(deviceManagementViewModelProvider
                        //       //         .notifier)
                        //       //     .getDevices();
                        //       ref
                        //           .read(graphqlServices)
                        //           .attachPolicy("")
                        //           .then((value) => print(value));
                        //       ScaffoldMessenger.of(context)
                        //           .showSnackBar(SnackBar(
                        //         content: Text("${data.message}"),
                        //         backgroundColor: Colors.green,
                        //       ));
                        //       // Navigator.of(context).pop();
                        //     },
                        //     error: (erro, stackTrace) {
                        //       // ref.read(isloadingPro.notifier).state = false;
                        //       List err = erro as List<GraphQLResponseError>;
                        //       // ref.read(errorPro.notifier).state =
                        //       //     err.first.message;
                        //       ScaffoldMessenger.of(context)
                        //           .showSnackBar(SnackBar(
                        //         content: Text(err.first.message.toString()),
                        //         backgroundColor: Colors.red,
                        //       ));
                        //     },
                        //     loading: () => const CircularProgressIndicator());
                        // AddDevicePage.show(context);
                        // _dialogBuilder(context);
                        // ref
                        //     .read(deviceManagementViewModelProvider.notifier)
                        //     .add(1, 1, 1, 1, "", "", "Test Device");
                        // AddDevicePage.show(context);
                        // DeviceSetupPage.show(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          // ref.watch(isloadingPro)!
          // Container(
          //     child: CircularProgressIndicator(),
          //   )
          Column(
            children: state.when(
                data: (data) {
                  return data
                      .map(
                        (e) => ListTile(
                          leading: const Icon(Icons.water_drop_outlined),
                          title: Text(e?.serialNumber ?? 'No Name'),
                          trailing: InkWell(
                            child: const Icon(Icons.edit),
                            onTap: () {
                              // DevicePage.show(context, e);
                              context.goNamed(AppRoute.editDevice.name,
                                  extra: e);
                            },
                          ),
                        ),
                      )
                      .toList();
                },
                error: ((error, stackTrace) {
                  return [Text('Error $error')];
                }),
                loading: (() => [const CircularProgressIndicator()])),
          )
        ],
      ),
    );
  }

  String _qrCodeResult = '';

  // Future<void> _scanQRCode() async {
  //   try {
  //     await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => Scaffold(body: ReaderWidget(
  //           onScan: (result) {
  //             _qrCodeResult = utf8.decode(base64.decode(result.text!));
  //             Navigator.of(context).pop();
  //           },
  //         )),
  //       ),
  //     );
  //     // });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
  //
  // Future<void> _dialogBuilder(BuildContext context) {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Consumer(
  //           builder: (context, ref, child) {
  //             return AlertDialog(
  //                 title: const Text('Claim a Device'),
  //                 content: Container(
  //                   height: 250,
  //                   width: 250,
  //                   child: ReaderWidget(
  //                     onScan: (result) async {
  //                       // Do something with the result
  //
  //                       final serialNumber =
  //                           utf8.decode(base64.decode(result.text!));
  //                       // Navigator.of(context).pop();
  //                       print(serialNumber);
  //                       final d = await ref
  //                           .read(graphqlServices)
  //                           .claimDevice(serialNumber);
  //
  //                       d.when(
  //                           data: (data) {
  //                             print(data.message);
  //                             ref
  //                                 .read(deviceManagementViewModelProvider
  //                                     .notifier)
  //                                 .getDevices();
  //                             // Navigator.of(context).pop();
  //                           },
  //                           error: (erro, stackTrace) {
  //                             List err = erro as List<GraphQLResponseError>;
  //                             ref.read(errorPro.notifier).state =
  //                                 err.first.message;
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                                 SnackBar(
  //                                     content:
  //                                         Text(err.first.message.toString())));
  //                           },
  //                           loading: () => const CircularProgressIndicator());
  //
  //                       // Navigator.of(context).pop();
  //                     },
  //                   ),
  //                 )
  //                 // TextFormField(
  //                 //   controller: deviceSN,
  //                 //   decoration: InputDecoration(
  //                 //     label: Text('Device Serial Number'),
  //                 //     errorText: ref.watch(errorPro),
  //                 //   ),
  //                 // ),
  //                 // actions: <Widget>[
  //                 //   TextButton(
  //                 //     style: TextButton.styleFrom(
  //                 //       textStyle: Theme.of(context).textTheme.labelLarge,
  //                 //     ),
  //                 //     child: const Text('Cancel'),
  //                 //     onPressed: () {
  //                 //       Navigator.of(context).pop();
  //                 //     },
  //                 //   ),
  //                 //   TextButton(
  //                 //     style: TextButton.styleFrom(
  //                 //       textStyle: Theme.of(context).textTheme.labelLarge,
  //                 //     ),
  //                 //     child: const Text('Add'),
  //                 //     onPressed: () async {
  //                 //       final d = await ref
  //                 //           .read(graphqlServices)
  //                 //           .claimDevice(deviceSN.text);
  //
  //                 //       d.when(
  //                 //           data: (data) {
  //                 //             print(data.message);
  //                 //             ref
  //                 //                 .read(
  //                 //                     deviceManagementViewModelProvider.notifier)
  //                 //                 .getDevices();
  //                 //             Navigator.of(context).pop();
  //                 //           },
  //                 //           error: (erro, stackTrace) {
  //                 //             List err = erro as List<GraphQLResponseError>;
  //                 //             ref.read(errorPro.notifier).state =
  //                 //                 err.first.message;
  //                 //             // ScaffoldMessenger.of(context).showSnackBar(
  //                 //             //     SnackBar(content: Text(error.toString())));
  //                 //           },
  //                 //           loading: () => const CircularProgressIndicator());
  //                 //     },
  //                 //   ),
  //                 // ],
  //                 );
  //           },
  //         );
  //       });
  // }
}

class AddDeviceDialog extends ConsumerWidget {
  const AddDeviceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final deviceSN = TextEditingController();
    final errorPro = StateProvider<String>((ref) {
      return validate('');
    });

    Future<void> submit() async {
      final sucess = await ref
          .read(deviceManagmentControllerProvider.notifier)
          .claimDevice(deviceSN.text);
      if (sucess && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Device Added Successfully'),
          backgroundColor: Colors.green,
        ));
        context.pop();
        ref.invalidate(devicesListFutureProvider);
      }
    }

    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(deviceManagmentControllerProvider);
        final error = ref.watch(errorPro);
        return AlertDialog(
          // <-- SEE HERE
          title: const Text('Add Device'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter Device ID'),
                state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : TextField(
                        controller: deviceSN,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Device ID',
                          errorText: error.isEmpty ? null : error,
                        ),
                        onChanged: (value) => ref
                            .read(errorPro.notifier)
                            .update((state) => state = validate(value)),
                      ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      Navigator.of(context).pop();
                    },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: error.isEmpty
                  ? state.isLoading
                      ? null
                      : () {
                          submit();
                        }
                  : null,
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

//   Future<void> _showAlertDialog() async {
//     final deviceSN = TextEditingController();
//     // ref.invalidate(deviceManagmentControllerProvider);
//     final errorPro = StateProvider<String>((ref) {
//       return validate('');
//     });

//     Future<void> submit(BuildContext context) async {
//       final sucess = await ref
//           .read(deviceManagmentControllerProvider.notifier)
//           .claimDevice(deviceSN.text);
//       if (sucess && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Device Added Successfully'),
//           backgroundColor: Colors.green,
//         ));
//         Navigator.of(context).pop();
//       }
//     }

//     return showDialog<void>(
//       context: context,
//       // barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return Consumer(
//           builder: (context, ref, child) {
//             final state = ref.watch(deviceManagmentControllerProvider);
//             final error = ref.watch(errorPro);
//             return AlertDialog(
//               // <-- SEE HERE
//               title: const Text('Add Device'),
//               content: SingleChildScrollView(
//                 child: ListBody(
//                   children: <Widget>[
//                     const Text('Enter Device ID'),
//                     state.isLoading
//                         ? const Center(child: CircularProgressIndicator())
//                         : TextField(
//                             controller: deviceSN,
//                             decoration: InputDecoration(
//                               // border: OutlineInputBorder(),
//                               labelText: 'Device ID',
//                               errorText: error.isEmpty ? null : error,
//                             ),
//                             onChanged: (value) => ref
//                                 .read(errorPro.notifier)
//                                 .update((state) => state = validate(value)),
//                           ),
//                   ],
//                 ),
//               ),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: state.isLoading
//                       ? null
//                       : () {
//                           Navigator.of(context).pop();
//                         },
//                   child: const Text('No'),
//                 ),
//                 TextButton(
//                   onPressed: error.isEmpty
//                       ? state.isLoading
//                           ? null
//                           : () {
//                               submit(context);
//                               // ref
//                               //     .read(deviceManagmentControllerProvider
//                               //         .notifier)
//                               //     .claimDevice(deviceSN.text);
//                             }
//                       : null,
//                   child: const Text('Yes'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

String validate(String value) {
  //check if value contain only numbers and letters and symbols and not empty
  if (value.isEmpty) {
    return 'device should not be empty';
  } else if (!RegExp(r'^[a-zA-Z0-9-]+$').hasMatch(value)) {
    // if (value.isNotEmpty) {
    return 'device should contain only numbers and letters and symbols';
    // }
  } else if (value.length > 32) {
    return 'device should not be more than 32 characters';
  }
  return '';
}
// }
