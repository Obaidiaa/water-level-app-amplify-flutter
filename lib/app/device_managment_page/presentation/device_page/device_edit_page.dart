import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_page/device_edit_controller.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/app/util/async_value_ui.dart';
import 'package:water_level_flutter/routing/app_router.dart';
import 'package:water_level_flutter/services/device_managment_services.dart';

class DeviceEditPage extends ConsumerStatefulWidget {
  DeviceEditPage({key, required this.device}) : super(key: key);
  Device device;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeviceEditPageState();
}

class _DeviceEditPageState extends ConsumerState<DeviceEditPage> {
  final thingNameController = TextEditingController();
  final heightController = TextEditingController();
  final highLevelAlarmController = TextEditingController();
  final lowLevelAlarmController = TextEditingController();
  final locationController = TextEditingController();
  bool notification = false;
  double? fontSizeText = 20;
  late Device device;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    device = widget.device;
    thingNameController.text = device.thingName ?? "";
    heightController.text =
        device.height == null ? '10' : device.height.toString();
    highLevelAlarmController.text =
        device.highLevelAlarm == null ? '5' : device.highLevelAlarm.toString();
    lowLevelAlarmController.text =
        device.lowLevelAlarm == null ? '0' : device.lowLevelAlarm.toString();
    notification = device.notification ?? false;
    locationController.text = device.location ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // handle error state and show alert dialog if error occurs in controller
    ref.listen<AsyncValue>(
      deviceEditControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(deviceEditControllerProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              child: Container(
                height: MediaQuery.of(context).size.height / 100 * 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Device ${device.thingName}',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: fontSizeText),
                          controller: thingNameController,
                          // initialValue: state.ThingName,
                          // onChanged: (value) => state.copyWith(ThingName: value),
                          autovalidateMode: AutovalidateMode.always,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text(
                                'Thing Name',
                                // style: TextStyle(fontSize: 25),
                              )),
                          validator: (value) {
                            if (value!.length > 32) {
                              return 'very long name should be less than 32';
                            }
                            if (value.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.always,
                          style: TextStyle(fontSize: fontSizeText),
                          controller: heightController,
                          maxLength: 5,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], //
                          // initialValue: state.Height.toString(),
                          decoration: const InputDecoration(
                            label: Text('Tank Height'),
                            suffix: Text('CM'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            if ((int.tryParse(value) ?? 0) > 10000) {
                              return 'Should be less than 10000';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: fontSizeText),
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.always,

                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          maxLength: 5,
                          controller: highLevelAlarmController,
                          // initialValue: state.HighLevelAlarm.toString(),
                          decoration: const InputDecoration(
                            label: Text('High Alarm set point'),
                            suffix: Text('CM'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Can\'t be empty';
                            } else if ((int.tryParse(value) ?? 0) >
                                (int.tryParse(heightController.text) ?? 0)) {
                              return 'Should be less than ${heightController.text}';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.always,
                          maxLength: 5,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(fontSize: fontSizeText),
                          controller: lowLevelAlarmController,
                          // initialValue: state.LowLevelAlarm.toString(),
                          // onChanged: (value) => device.lowLevelAlarm = 342,
                          decoration: const InputDecoration(
                            label: Text('Low Alarm set point'),
                            suffix: Text('CM'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Can\'t be empty';
                            } else if ((int.tryParse(value) ?? 0) >=
                                (int.tryParse(highLevelAlarmController.text) ??
                                    0)) {
                              return 'Should be less than ${highLevelAlarmController.text}';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.always,
                          maxLength: 150,
                          // inputFormatters: <TextInputFormatter>[
                          //   FilteringTextInputFormatter.digitsOnly
                          // ],
                          style: TextStyle(fontSize: fontSizeText),
                          controller: locationController,
                          // initialValue: state.LowLevelAlarm.toString(),
                          // onChanged: (value) => device.lowLevelAlarm = 342,
                          decoration: const InputDecoration(
                            label: Text('Device Location'),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Can\'t be empty';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: state.isLoading
                              ? null
                              : () async {
                                  if (await ref
                                      .read(
                                          deviceEditControllerProvider.notifier)
                                      .declaimDevice(device.serialNumber)) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Device ${device.thingName} deleted"),
                                      backgroundColor: Colors.green,
                                    ));
                                    if (mounted) {
                                      context.pop();
                                      ref.invalidate(devicesListFutureProvider);
                                    }
                                  }
                                },
                          child: const Text("Delete Device")),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notification',
                              style: TextStyle(fontSize: fontSizeText! + 10),
                            ),
                            SizedBox(
                              width: 90,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Switch(
                                  // This bool value toggles the switch.
                                  value: notification,
                                  activeColor: Colors.red,
                                  onChanged: (value) => setState(() {
                                    notification = value;
                                    print(notification);
                                    // onChange(value);
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // child: TextFormField(
                        //   style: TextStyle(fontSize: 25),
                        //   controller: notificationController,
                        //   decoration: const InputDecoration(
                        //     label: Text('Low Alarm set point'),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (value) {
                        //     if (value!.isEmpty) {
                        //       return 'Can\'t be empty';
                        //     }
                        //   },
                        // ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        ref
                                            .read(deviceEditControllerProvider
                                                .notifier)
                                            .updateDevice(
                                                device.serialNumber,
                                                thingNameController.text,
                                                int.parse(
                                                    heightController.text),
                                                int.parse(
                                                    highLevelAlarmController
                                                        .text),
                                                int.parse(
                                                    lowLevelAlarmController
                                                        .text),
                                                notification,
                                                locationController.text)
                                            .then((value) =>
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text("device updated"),
                                                  backgroundColor: Colors.green,
                                                )));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Please fill all the fields"),
                                          backgroundColor: Colors.red,
                                        ));
                                      }
                                    },
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    // textAlign: TextAlign.center,
                                    'Save',
                                    style:
                                        TextStyle(fontSize: fontSizeText! + 10),
                                  ),
                                ),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () => Navigator.pop(context),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: Text(
                                    // textAlign: TextAlign.center,
                                    'Close',
                                    style:
                                        TextStyle(fontSize: fontSizeText! + 10),
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
