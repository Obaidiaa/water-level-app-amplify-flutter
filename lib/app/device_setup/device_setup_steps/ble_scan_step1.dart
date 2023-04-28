import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
import 'package:water_level_flutter/services/ble_services.dart';
import 'package:water_level_flutter/widgets.dart';

class BLEScanStep1 extends ConsumerStatefulWidget {
  const BLEScanStep1({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BLEScanStep1State();
}

class _BLEScanStep1State extends ConsumerState<BLEScanStep1> {
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   ref.watch(bleServicesProvider).stopScan();
  //   // super.dispose();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(bleServicesProvider).startScan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BluetoothState>(
        stream: FlutterBluePlus.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return FindDevicesScreen(ref: ref);
          }
          return BluetoothOffScreen(state: state);
        });
  }
}

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.bluetooth_disabled,
              size: 200.0,
              color: Colors.white54,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .subtitle2
                  ?.copyWith(color: Colors.white),
            ),
            ElevatedButton(
              child: const Text('TURN ON'),
              onPressed: Platform.isAndroid
                  ? () => FlutterBluePlus.instance.turnOn()
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class FindDevicesScreen extends StatelessWidget {
  const FindDevicesScreen({Key? key, required this.ref}) : super(key: key);
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final e = ref.watch(bleStateProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // !e.contains('All Ready with')
          //     ? const Center(child: CircularProgressIndicator())
          //     : Text(e),
          Center(
              child: Text(
            e,
            style: const TextStyle(
              fontSize: 49,
            ),
            textAlign: TextAlign.center,
          )),
        ],
      ),
      // floatingActionButton: StreamBuilder<bool>(
      //   stream: FlutterBluePlus.instance.isScanning,
      //   initialData: false,
      //   builder: (c, snapshot) {
      //     if (snapshot.data!) {
      //       return FloatingActionButton(
      //         onPressed: () => FlutterBluePlus.instance.stopScan(),
      //         backgroundColor: Colors.red,
      //         child: const Icon(Icons.stop),
      //       );
      //     } else {
      //       return FloatingActionButton(
      //           child: const Icon(Icons.search),
      //           onPressed: () => FlutterBluePlus.instance
      //               .startScan(timeout: const Duration(seconds: 4)));
      //     }
      //   },
      // ),
    );
  }
}
