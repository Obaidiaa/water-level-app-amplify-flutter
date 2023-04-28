import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_steps/ble_scan_step1.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_steps/send_credential_to_device_step3.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_steps/wifi_credential_step2.dart';
import 'package:water_level_flutter/routing/app_router.dart';
import 'package:water_level_flutter/services/ble_services.dart';
import 'package:water_level_flutter/services/wifi_services.dart';
import 'package:wifi_scan/wifi_scan.dart';

class DeviceSetupPage extends ConsumerStatefulWidget {
  const DeviceSetupPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(
      context,
    ).pushNamed(
      AppRoutes.deviceSetupPage,
      // arguments: settings,
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceSetupPageState();
}

final currentStepProvider = StateProvider<int>((ref) => 0);

class _DeviceSetupPageState extends ConsumerState<DeviceSetupPage> {
  StepperType stepperType = StepperType.horizontal;

  @override
  void dispose() {
    // TODO: implement dispose
    ref.watch(bleServicesProvider).stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentStep = ref.watch(currentStepProvider);
    tapped(int step) {
      ref.watch(currentStepProvider.notifier).update((state) => state = step);
    }

    continued() {
      currentStep < 2
          ? ref
              .watch(currentStepProvider.notifier)
              .update((state) => state += 1)
          : ref.watch(bleServicesProvider).writeData();
    }

    cancel() {
      currentStep > 0
          ? ref
              .watch(currentStepProvider.notifier)
              .update((state) => state -= 1)
          : null;
    }

    List<Step> steps = [
      Step(
        title: Text('Ble scan'),
        content: SizedBox(height: 500, child: BLEScanStep1()),
        isActive: currentStep == 0,
        state: currentStep > 0
            ? StepState.complete
            : currentStep == 0
                ? StepState.editing
                : StepState.disabled,
      ),
      Step(
        title: Text('WiFi scan'),
        content: Container(
            constraints: BoxConstraints.expand(height: 500),
            child: WiFiCredentialStep2()),
        isActive: currentStep == 1,
        state: currentStep > 1
            ? StepState.complete
            : currentStep == 1
                ? StepState.editing
                : StepState.disabled,
      ),
      Step(
        title: Text('Final'),
        content: Container(
            constraints: BoxConstraints.expand(height: 500),
            child: SendCredentialToDevice()),
        isActive: currentStep == 2,
        state: currentStep > 2
            ? StepState.complete
            : currentStep == 2
                ? StepState.editing
                : StepState.disabled,
      ),
    ];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       'Device Setup',
            //       style: TextStyle(fontSize: 42),
            //     )
            //   ],
            // ),
            Expanded(
              child: Stepper(
                controlsBuilder: ((context, details) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (details.currentStep > 0)
                          ElevatedButton(
                            onPressed: details.onStepCancel,
                            child: Text('Back'),
                          ),

                        if (details.currentStep == 2)
                          ElevatedButton(
                            onPressed: ref.watch(bleConnectionStatus)
                                ? details.onStepContinue
                                : null,
                            child: const Text('Send'),
                          ),

                        if (details.currentStep == 0)
                          ElevatedButton(
                            onPressed: ref.watch(bleConnectionStatus)
                                ? details.onStepContinue
                                : null,
                            child: const Text('Contenue'),
                          ),

                        // if (details.currentStep == 1)
                        //   ElevatedButton(
                        //     onPressed: ref
                        //                 .watch(wiFiServicesProvider)
                        //                 .wifiAccesPointCredentials['ssid'] !=
                        //             ''
                        //         ? details.onStepContinue
                        //         : null,
                        //     child: const Text('Contenue'),
                        //   ),
                      ],
                    ),
                  );
                }),
                steps: steps,
                currentStep: currentStep,
                physics: ScrollPhysics(),
                type: stepperType,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
              ),
            )
          ],
        ),
      ),
    );
  }
}
