import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_managment_controller.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/app/util/async_value_ui.dart';
import 'package:water_level_flutter/routing/app_router.dart';

import 'package:flutter_zxing/flutter_zxing.dart';

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
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.5),
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
                    children: [
                      Icon(
                        Icons.device_hub,
                        size: Theme.of(context).textTheme.titleMedium!.fontSize,
                        // size: 35.sp,
                      ),
                      Text(
                        'Devices',
                        style: Theme.of(context).textTheme.titleMedium,
                        // style: TextStyle(fontSize: 35.sp),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0.sp),
                    child: InkWell(
                      child: Icon(
                        Icons.add,
                        size: Theme.of(context).textTheme.titleMedium!.fontSize,

                        // size: 40.sp,
                      ),
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
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              children: state.when(
                  data: (data) {
                    return data
                        .map(
                          (e) => ListTile(
                            leading: Icon(Icons.water_drop_outlined),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                e?.serialNumber ?? 'No Name',
                                style: Theme.of(context).textTheme.bodyMedium,
                                // style: TextStyle(fontSize: 15.sp),
                              ),
                            ),
                            trailing: InkWell(
                              child: const Icon(
                                Icons.edit,
                                // size: Theme.of(context)
                                //     .textTheme
                                //     .bodyMedium!
                                //     .fontSize,
                              ),
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
            ),
          )
        ],
      ),
    );
  }
}

class AddDeviceDialog extends HookConsumerWidget {
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

    final TabController tabController =
        useTabController(initialLength: 2, initialIndex: 1);

    return HookConsumer(
      builder: (context, ref, child) {
        final state = ref.watch(deviceManagmentControllerProvider);
        final error = ref.watch(errorPro);
        final useQRCode = useState(false);
        return AlertDialog(
          // <-- SEE HERE
          title: Text('Add Device',
              style: Theme.of(context).textTheme.titleMedium),

          content: SingleChildScrollView(
            child: Column(
              children: [
                TabBar(
                  onTap: (value) {
                    print(value);
                    if (value == 0) {
                      useQRCode.value = true;
                    } else {
                      useQRCode.value = false;
                    }
                  },
                  tabs: const [
                    Tab(
                      text: 'Scan QR Code',
                    ),
                    Tab(
                      text: 'Enter Device ID',
                    ),
                  ],
                  controller: tabController,
                ),
                ListBody(
                  children: useQRCode.value
                      ? [
                          Container(
                            height: 250,
                            width: 250,
                            child: ReaderWidget(
                              onScan: (result) async {
                                final serialNumber =
                                    utf8.decode(base64.decode(result.text!));
                                print(serialNumber);
                                deviceSN.text = serialNumber;
                                ref.read(errorPro.notifier).update(
                                    (state) => state = validate(serialNumber));
                                tabController.animateTo(1);
                                useQRCode.value = false;
                              },
                            ),
                          )
                        ]
                      : [
                          state.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : TextField(
                                  controller: deviceSN,
                                  decoration: InputDecoration(
                                    labelText: 'Device ID',
                                    labelStyle:
                                        Theme.of(context).textTheme.bodyMedium,
                                    errorText: error.isEmpty ? null : error,
                                  ),
                                  onChanged: (value) => ref
                                      .read(errorPro.notifier)
                                      .update(
                                          (state) => state = validate(value)),
                                ),
                        ],
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
