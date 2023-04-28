import 'dart:convert';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_page.dart';
import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_view_model.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
import 'package:water_level_flutter/models/ThingOwnerManagerRes.dart';
import 'package:water_level_flutter/services/datastore_services.dart';
import 'package:water_level_flutter/services/device_management_notifier.dart';
import 'package:water_level_flutter/services/device_managment_services.dart';
import 'package:water_level_flutter/services/graphql_services.dart';

import 'package:flutter_zxing/flutter_zxing.dart';

import '../../models/Device.dart';

class DevicesManagmentPage extends ConsumerStatefulWidget {
  const DevicesManagmentPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DevicesManagmentPageState();
}

final errorPro = StateProvider<String?>((ref) {
  return null;
});

final isloadingPro = StateProvider<bool?>((ref) {
  return false;
});

class _DevicesManagmentPageState extends ConsumerState<DevicesManagmentPage> {
  @override
  Widget build(BuildContext context) {
    // ref.watch(deviceManagementViewModelProvider);
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
                  offset: Offset(0, 0.75), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              height: MediaQuery.of(context).size.height / 100 * 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Devices',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      child: const Icon(Icons.add, size: 40),
                      onTap: () async {
                        ref.read(isloadingPro.notifier).state = true;
                        await _scanQRCode();

                        final d = await ref
                            .watch(deviceManagementServicesProvider)
                            .claimDevice(_qrCodeResult);

                        d.when(
                            data: (data) {
                              print(data);
                              ref.read(isloadingPro.notifier).state = false;
                              ref
                                  .read(deviceManagementViewModelProvider
                                      .notifier)
                                  .getDevices();
                              ref
                                  .read(graphqlServices)
                                  .attachPolicy("")
                                  .then((value) => print(value));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("${data.message}"),
                                backgroundColor: Colors.green,
                              ));
                              // Navigator.of(context).pop();
                            },
                            error: (erro, stackTrace) {
                              ref.read(isloadingPro.notifier).state = false;
                              List err = erro as List<GraphQLResponseError>;
                              ref.read(errorPro.notifier).state =
                                  err.first.message;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(err.first.message.toString()),
                                backgroundColor: Colors.red,
                              ));
                            },
                            loading: () => const CircularProgressIndicator());
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
          ref.watch(isloadingPro)!
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: ref.watch(deviceManagementViewModelProvider).when(
                      data: (data) {
                        return data
                            .map(
                              (e) => ListTile(
                                leading: Text('76%'),
                                title: Text('${e!.thingName}'),
                                trailing: InkWell(
                                  child: Icon(Icons.edit),
                                  onTap: () {
                                    DevicePage.show(context, e);
                                  },
                                ),
                              ),
                            )
                            .toList();
                      },
                      error: ((error, stackTrace) {
                        return [Text('Error $error')];
                      }),
                      loading: (() => [CircularProgressIndicator()])),
                )
        ],
      ),
    );
  }

  String _qrCodeResult = '';

  Future<void> _scanQRCode() async {
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(body: ReaderWidget(
            onScan: (result) {
              _qrCodeResult = utf8.decode(base64.decode(result.text!));
              Navigator.of(context).pop();
            },
          )),
        ),
      );
      // });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Consumer(
            builder: (context, ref, child) {
              return AlertDialog(
                  title: const Text('Claim a Device'),
                  content: Container(
                    height: 250,
                    width: 250,
                    child: ReaderWidget(
                      onScan: (result) async {
                        // Do something with the result

                        final serialNumber =
                            utf8.decode(base64.decode(result.text!));
                        // Navigator.of(context).pop();
                        print(serialNumber);
                        final d = await ref
                            .read(graphqlServices)
                            .claimDevice(serialNumber);

                        d.when(
                            data: (data) {
                              print(data.message);
                              ref
                                  .read(deviceManagementViewModelProvider
                                      .notifier)
                                  .getDevices();
                              // Navigator.of(context).pop();
                            },
                            error: (erro, stackTrace) {
                              List err = erro as List<GraphQLResponseError>;
                              ref.read(errorPro.notifier).state =
                                  err.first.message;
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(err.first.message.toString())));
                            },
                            loading: () => const CircularProgressIndicator());

                        // Navigator.of(context).pop();
                      },
                    ),
                  )
                  // TextFormField(
                  //   controller: deviceSN,
                  //   decoration: InputDecoration(
                  //     label: Text('Device Serial Number'),
                  //     errorText: ref.watch(errorPro),
                  //   ),
                  // ),
                  // actions: <Widget>[
                  //   TextButton(
                  //     style: TextButton.styleFrom(
                  //       textStyle: Theme.of(context).textTheme.labelLarge,
                  //     ),
                  //     child: const Text('Cancel'),
                  //     onPressed: () {
                  //       Navigator.of(context).pop();
                  //     },
                  //   ),
                  //   TextButton(
                  //     style: TextButton.styleFrom(
                  //       textStyle: Theme.of(context).textTheme.labelLarge,
                  //     ),
                  //     child: const Text('Add'),
                  //     onPressed: () async {
                  //       final d = await ref
                  //           .read(graphqlServices)
                  //           .claimDevice(deviceSN.text);

                  //       d.when(
                  //           data: (data) {
                  //             print(data.message);
                  //             ref
                  //                 .read(
                  //                     deviceManagementViewModelProvider.notifier)
                  //                 .getDevices();
                  //             Navigator.of(context).pop();
                  //           },
                  //           error: (erro, stackTrace) {
                  //             List err = erro as List<GraphQLResponseError>;
                  //             ref.read(errorPro.notifier).state =
                  //                 err.first.message;
                  //             // ScaffoldMessenger.of(context).showSnackBar(
                  //             //     SnackBar(content: Text(error.toString())));
                  //           },
                  //           loading: () => const CircularProgressIndicator());
                  //     },
                  //   ),
                  // ],
                  );
            },
          );
        });
  }
}
