// import 'dart:async';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
// import 'package:water_level_flutter/app/device_setup/device_setup_viewmodel.dart';
// import 'package:water_level_flutter/services/wifi_services.dart';
// import 'package:wifi_scan/wifi_scan.dart';

// class WiFiCredentialStep2 extends ConsumerStatefulWidget {
//   const WiFiCredentialStep2({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _WiFiCredentialStep2State();
// }

// // final wiFiAccessPointProvider = StateProvider<String>((ref) => '');

// class _WiFiCredentialStep2State extends ConsumerState<WiFiCredentialStep2> {
//   // build row that can display info, based on label: value pair.
//   Widget _buildInfo(String label, dynamic value) => Container(
//         decoration: const BoxDecoration(
//             border: Border(bottom: BorderSide(color: Colors.grey))),
//         child: Row(
//           children: [
//             Text("$label: ",
//                 style: const TextStyle(fontWeight: FontWeight.bold)),
//             Expanded(child: Text(value.toString()))
//           ],
//         ),
//       );

//   // build access point tile.
//   Widget _buildAccessPointTile(BuildContext context, WiFiAccessPoint ap) {
//     final title = ap.ssid.isNotEmpty ? ap.ssid : "**EMPTY**";
//     final signalIcon =
//         ap.level >= -80 ? Icons.signal_wifi_4_bar : Icons.signal_wifi_0_bar;
//     return ListTile(
//       visualDensity: VisualDensity.compact,
//       leading: Icon(signalIcon),
//       title: Text(title),
//       subtitle: Text(ap.capabilities),
//       onTap: () => showDialog(
//           context: context,
//           builder: (BuildContext context) =>
//               // const Dialog(child: AddCommand()))
//               Dialog(child: CustomSSID(ap.ssid))).then((value) {}),
//     );
//     // ref.watch(deviceSetupViewModelProvider).accessPoint = ap;
//     // ref.watch(wiFiAccessPointProvider.notifier).update((state) => ap.ssid);
//     // ref.watch(currentStepProvider.notifier).update((state) => state += 1);

//     // showDialog(
//     //   context: context,
//     //   builder: (context) => AlertDialog(
//     //     title: Text(title),
//     //     content: Column(
//     //       mainAxisSize: MainAxisSize.min,
//     //       children: [
//     //         _buildInfo("BSSDI", ap.bssid),
//     //         _buildInfo("Capability", ap.capabilities),
//     //         _buildInfo("frequency", "${ap.frequency}MHz"),
//     //         _buildInfo("level", ap.level),
//     //         _buildInfo("standard", ap.standard),
//     //         _buildInfo("centerFrequency0", "${ap.centerFrequency0}MHz"),
//     //         _buildInfo("centerFrequency1", "${ap.centerFrequency1}MHz"),
//     //         _buildInfo("channelWidth", ap.channelWidth),
//     //         _buildInfo("isPasspoint", ap.isPasspoint),
//     //         _buildInfo("operatorFriendlyName", ap.operatorFriendlyName),
//     //         _buildInfo("venueName", ap.venueName),
//     //         _buildInfo("is80211mcResponder", ap.is80211mcResponder),
//     //       ],
//     //     ),
//     //   ),
//     // ),
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wiFiAccessPoints = ref.watch(getWiFiAcces);

//     return FutureBuilder<bool>(
//       // future: WiFiScan.instance.hasCapability(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (!snapshot.data!) {
//           return const Center(child: Text("WiFi scan not supported."));
//         }
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//           child: SizedBox(
//             height: 500,
//             width: 500,
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('Refresh'),
//                       onPressed: () => ref.refresh(getWiFiAcces),
//                     ),
//                     ElevatedButton(
//                         onPressed: () => showDialog(
//                             context: context,
//                             builder: (BuildContext context) =>
//                                 // const Dialog(child: AddCommand()))
//                                 const Dialog(
//                                   child: CustomSSID(''),
//                                 )).then((value) {}),
//                         child: const Icon(Icons.add)),
//                   ],
//                 ),
//                 const Divider(),
//                 Flexible(
//                   child: Center(
//                     child: wiFiAccessPoints.when(
//                         data: (data) {
//                           return data!.isEmpty
//                               ? const Text("NO SCANNED RESULTS")
//                               : ListView.builder(
//                                   itemCount: data.length,
//                                   itemBuilder: (context, i) =>
//                                       _buildAccessPointTile(context, data[i]));
//                         },
//                         error: (error, trace) {
//                           return Text(error.toString());
//                         },
//                         loading: () => const CircularProgressIndicator()),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   /// Show snackbar.
//   void kShowSnackBar(BuildContext context, String message) {
//     if (kDebugMode) print(message);
//     ScaffoldMessenger.of(context)
//       ..hideCurrentSnackBar()
//       ..showSnackBar(SnackBar(content: Text(message)));
//   }
// }

// class CustomSSID extends ConsumerStatefulWidget {
//   const CustomSSID(this.ssid, {Key? key}) : super(key: key);

//   final ssid;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _CustomSSIDState();
// }

// class _CustomSSIDState extends ConsumerState<CustomSSID> {
//   onSubmit(WidgetRef ref, String ssid, String pass) {
//     ref.read(wiFiServicesProvider).wifiAccesPointCredentials['ssid'] = ssid;
//     ref.read(wiFiServicesProvider).wifiAccesPointCredentials['pass'] = pass;
//   }

//   final _formKey = GlobalKey<FormBuilderState>();
//   bool autoValidate = true;
//   bool readOnly = false;
//   bool showSegmentedControl = true;
//   bool ssidHasError = true;
//   bool passHasError = true;
//   @override
//   void initState() {
//     super.initState();
//     ssidHasError =
//         widget.ssid.length <= 0 || widget.ssid.length > 32 ? true : false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final deviceViewModelProvider = ref.watch(wiFiServicesProvider);
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         height: 300,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             FormBuilder(
//                 key: _formKey,
//                 onChanged: () {
//                   _formKey.currentState!.save();
//                   debugPrint(_formKey.currentState!.value.toString());
//                 },
//                 autovalidateMode: AutovalidateMode.disabled,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FormBuilderTextField(
//                         autofocus: true,
//                         initialValue: widget.ssid,
//                         autovalidateMode: AutovalidateMode.always,
//                         name: 'WiFi Name',
//                         decoration: InputDecoration(
//                           labelText: 'WiFi Name',
//                           suffixIcon: ssidHasError
//                               ? const Icon(Icons.error, color: Colors.red)
//                               : const Icon(Icons.check, color: Colors.green),
//                         ),

//                         onChanged: (val) {
//                           setState(() {
//                             ssidHasError = !(_formKey
//                                     .currentState?.fields['WiFi Name']
//                                     ?.validate() ??
//                                 false);
//                           });
//                         },
//                         validator: FormBuilderValidators.compose([
//                           FormBuilderValidators.required(),
//                           FormBuilderValidators.maxLength(32),
//                         ]),
//                         //
//                         textInputAction: TextInputAction.next,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: FormBuilderTextField(
//                         autovalidateMode: AutovalidateMode.always,
//                         name: 'WiFi Password',
//                         decoration: InputDecoration(
//                           labelText: 'WiFi Password',
//                           suffixIcon: passHasError
//                               ? const Icon(Icons.error, color: Colors.red)
//                               : const Icon(Icons.check, color: Colors.green),
//                         ),
//                         onChanged: (val) {
//                           setState(() {
//                             passHasError = !(_formKey
//                                     .currentState?.fields['WiFi Password']
//                                     ?.validate() ??
//                                 false);
//                           });
//                         },
//                         validator: FormBuilderValidators.compose([
//                           FormBuilderValidators.required(),
//                           FormBuilderValidators.maxLength(32),
//                           FormBuilderValidators.minLength(8),
//                         ]),
//                         //
//                         textInputAction: TextInputAction.next,
//                       ),
//                     ),
//                   ],
//                 )),
//             Row(
//               children: <Widget>[
//                 Expanded(
//                   child: MaterialButton(
//                     color: Theme.of(context).colorScheme.secondary,
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       _formKey.currentState!.save();
//                       if (_formKey.currentState!.validate()) {
//                         print(_formKey.currentState!.value);
//                         deviceViewModelProvider
//                                 .wifiAccesPointCredentials['ssid'] =
//                             _formKey.currentState!.value['WiFi Name'];
//                         deviceViewModelProvider
//                                 .wifiAccesPointCredentials['pass'] =
//                             _formKey.currentState!.value['WiFi Password'];
//                         ref
//                             .watch(currentStepProvider.notifier)
//                             .update((state) => state += 1);
//                         Navigator.pop(context);
//                       } else {
//                         print("validation failed");
//                       }
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: MaterialButton(
//                     color: Theme.of(context).colorScheme.secondary,
//                     child: const Text(
//                       "Close",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     onPressed: () {
//                       _formKey.currentState!.reset();
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
