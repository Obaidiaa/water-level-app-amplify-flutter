// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
// import 'package:water_level_flutter/app/device_managment_page/presentation/device_page/device_edit_controller.dart';
// import 'package:water_level_flutter/routing/app_router.dart';
// import 'package:water_level_flutter/services/device_managment_services.dart';

// class DeviceEditPage extends ConsumerStatefulWidget {
//   DeviceEditPage({key, required this.device}) : super(key: key);
//   Device device;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DeviceEditPageState();
// }

// class _DeviceEditPageState extends ConsumerState<DeviceEditPage> {
//   double? fontSizeText = 20;
//   @override
//   Widget build(BuildContext context) {
//     Device device = widget.device;
//     // final state = ref.watch(deviceEditPageViewModelProvider(device));
//     // final d = ref.read(deviceEditPageViewModelProvider(device).notifier);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.5),
//                       spreadRadius: 0,
//                       blurRadius: 7,
//                       offset: Offset(0, 0.75), // changes position of shadow
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 100 * 10,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Device ${device.thingName}',
//                           style: TextStyle(fontSize: 25),
//                         ),
//                       ),
//                       // Padding(
//                       // padding: const EdgeInsets.only(right: 20.0),
//                       // child: InkWell(
//                       //   child: Icon(Icons.add, size: 40),
//                       //   onTap: () {
//                       //     // DeviceSetupPage.show(context);
//                       //   },
//                       // ),
//                       // )
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 child: Form(
//                     child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         style: TextStyle(fontSize: fontSizeText),
//                         controller: ref
//                             .read(deviceEditControllerProvider)
//                             .thingNameController,
//                         // initialValue: state.ThingName,
//                         // onChanged: (value) => state.copyWith(ThingName: value),
//                         autovalidateMode: AutovalidateMode.always,
//                         decoration: const InputDecoration(
//                             border: OutlineInputBorder(),
//                             label: Text(
//                               'Thing Name',
//                               // style: TextStyle(fontSize: 25),
//                             )),
//                         validator: (value) {
//                           if (value!.length > 32) {
//                             return 'very long name should be less than 32';
//                           }
//                           if (value.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         autovalidateMode: AutovalidateMode.always,
//                         style: TextStyle(fontSize: fontSizeText),
//                         controller: d.heightController,
//                         maxLength: 5,
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ], //
//                         // initialValue: state.Height.toString(),
//                         decoration: const InputDecoration(
//                           label: Text('Tank Height'),
//                           suffix: Text('CM'),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                           if (int.parse(value) > 10000) {
//                             return 'Should be less than 10000';
//                           }
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         style: TextStyle(fontSize: fontSizeText),
//                         keyboardType: TextInputType.number,
//                         autovalidateMode: AutovalidateMode.always,

//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         maxLength: 5,
//                         controller: d.highLevelAlarmController,
//                         // initialValue: state.HighLevelAlarm.toString(),
//                         decoration: const InputDecoration(
//                           label: Text('High Alarm set point'),
//                           suffix: Text('CM'),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                           if (int.parse(value) >
//                               int.parse(d.heightController.text)) {
//                             return 'Should be less than ${d.heightController.text}';
//                           }
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: TextFormField(
//                         keyboardType: TextInputType.number,
//                         autovalidateMode: AutovalidateMode.always,
//                         maxLength: 5,
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ],
//                         style: TextStyle(fontSize: fontSizeText),
//                         controller: d.lowLevelAlarmController,
//                         // initialValue: state.LowLevelAlarm.toString(),
//                         // onChanged: (value) => device.lowLevelAlarm = 342,
//                         decoration: const InputDecoration(
//                           label: Text('Low Alarm set point'),
//                           suffix: Text('CM'),
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Can\'t be empty';
//                           }
//                           if (int.parse(value) >=
//                               int.parse(d.highLevelAlarmController.text)) {
//                             return 'Should be less than ${d.highLevelAlarmController.text}';
//                           }
//                         },
//                       ),
//                     ),
//                     ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red),
//                         onPressed: () async {
//                           final d = await ref
//                               .read(deviceEditPageViewModelProvider(device)
//                                   .notifier)
//                               .onDelete(context);
//                           d.when(
//                               data: (data) {
//                                 ref
//                                     .read(deviceManagementViewModelProvider
//                                         .notifier)
//                                     .getDevices();
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content: Text("${data.message}"),
//                                   backgroundColor: Colors.green,
//                                 ));
//                                 Navigator.of(context).pop();
//                               },
//                               error: (error, stackTrace) {
//                                 final err = error as List<GraphQLResponseError>;
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content: Text(err.first.message),
//                                   backgroundColor: Colors.red,
//                                 ));
//                               },
//                               loading: () => print("lodding"));
//                         },
//                         child: Text("Delete Device")),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Notification',
//                             style: TextStyle(fontSize: fontSizeText! + 10),
//                           ),
//                           SizedBox(
//                             width: 90,
//                             child: FittedBox(
//                               fit: BoxFit.fill,
//                               child: Switch(
//                                 // This bool value toggles the switch.
//                                 value: d.notification,
//                                 activeColor: Colors.red,
//                                 onChanged: (value) => setState(() {
//                                   d.notification = value;
//                                   d.onChange(value);
//                                 }),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // child: TextFormField(
//                       //   style: TextStyle(fontSize: 25),
//                       //   controller: notificationController,
//                       //   decoration: const InputDecoration(
//                       //     label: Text('Low Alarm set point'),
//                       //     border: OutlineInputBorder(),
//                       //   ),
//                       //   validator: (value) {
//                       //     if (value!.isEmpty) {
//                       //       return 'Can\'t be empty';
//                       //     }
//                       //   },
//                       // ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () {
//                               d.save(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Center(
//                                 child: Text(
//                                   // textAlign: TextAlign.center,
//                                   'Save',
//                                   style:
//                                       TextStyle(fontSize: fontSizeText! + 10),
//                                 ),
//                               ),
//                             )),
//                         ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red),
//                             onPressed: () => Navigator.pop(context),
//                             child: Padding(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Center(
//                                 child: Text(
//                                   // textAlign: TextAlign.center,
//                                   'Close',
//                                   style:
//                                       TextStyle(fontSize: fontSizeText! + 10),
//                                 ),
//                               ),
//                             )),
//                       ],
//                     )
//                   ],
//                 )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
