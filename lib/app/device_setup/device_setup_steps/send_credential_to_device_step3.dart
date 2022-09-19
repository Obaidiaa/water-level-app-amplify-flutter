import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus/gen/flutterblueplus.pb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_steps/ble_scan_step1.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_viewmodel.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:water_level_flutter/services/ble_services.dart';
import 'package:water_level_flutter/services/wifi_services.dart';
import 'package:water_level_flutter/widgets.dart';

class SendCredentialToDevice extends ConsumerStatefulWidget {
  const SendCredentialToDevice({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SendCredentialToDeviceState();
}

class _SendCredentialToDeviceState
    extends ConsumerState<SendCredentialToDevice> {
  @override
  Widget build(BuildContext context) {
    final d = ref.watch(wiFiServicesProvider);
    TextStyle textStyle = TextStyle(fontSize: 25);
    return Column(
      children: [
        Text(
          'BLE Device: ${ref.watch(bleServicesProvider).bluetoothDevice?.name ?? ''}',
          style: textStyle,
        ),
        Text(
          'WiFi SSID: ${d.wifiAccesPointCredentials['ssid']}',
          style: textStyle,
        ),
        Text(
          'WiFi Password:  ${d.wifiAccesPointCredentials['pass']}',
          style: textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${ref.watch(bleStateProvider)}: ',
              style: textStyle,
            ),
            StreamBuilder(
              stream: ref.watch(bleServicesProvider).bluetoothDevice?.state,
              initialData: BluetoothDeviceState.disconnected,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  child: snapshot.data == BluetoothDeviceState.disconnected
                      ? const Icon(
                          Icons.error,
                          color: Colors.red,
                          size: 25,
                        )
                      : const Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 25,
                        ),
                );
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WiFi Credentials Received: ',
              style: textStyle,
            ),
            !ref.watch(wiFicredentialReceived)
                ? const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 25,
                  )
                : const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 25,
                  ),
          ],
        ),
      ],
    );
  }
}
