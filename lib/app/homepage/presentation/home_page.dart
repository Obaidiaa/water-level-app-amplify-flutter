import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/app/homepage/presentation/home_page_controller.dart';
import 'package:water_level_flutter/packages/time_ago_since_now.dart';
import 'package:water_level_flutter/services/mqtt_services.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

// final levelColor = StateProvider((ref) => Colors.red);

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    ref.read(homePageControllerProvider.notifier).initMQTT();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(devicesListFutureProvider);
    final mqttStatus = ref.watch(mqttStatusNotifier);
    return Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(),
                Row(
                  children: const [
                    Icon(
                      Icons.ac_unit_sharp,
                      size: 35,
                    ),
                    Text(
                      'Level',
                      style: TextStyle(fontSize: 35),
                    ),
                  ],
                ),

                // ref.watch(mqttStatusNotifier)!

                Container(
                  child: mqttStatus!
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 35,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            // ref.refresh(mqttServicesProvider);
                            ref.read(mqttServicesProvider).init();
                            // isInit = true;
                          },
                          child: const Text('connect')),
                ),
              ],
            ),
          ),
        ),
        // ElevatedButton(
        //     onPressed: () => ref.read(mqttServicesProvider).disconnect(),
        //     child: const Text('disconnect')),
        state.when(
            data: (data) {
              if (mqttStatus) {
                ref.read(mqttServicesProvider).getAllDeviceData(data);
              }
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Color levelColor = Colors.red;
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: LevelCard(data: data[index]),
                      );
                    }),
              );
            },
            error: ((error, stackTrace) {
              return Text('Error $error');
            }),
            loading: (() => const CircularProgressIndicator())),
      ],
    );
  }
}

class LevelCard extends ConsumerStatefulWidget {
  const LevelCard({
    this.data,
    super.key,
  });
  final data;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LevelCardState();
}

final timeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class _LevelCardState extends ConsumerState<LevelCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 2. declare Ticker
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ref.read(timeProvider.notifier).state = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final lastUpdate = ref.watch(devicesLevelData)[widget.data?.serialNumber];
    final t = lastUpdate?[1] ?? 'No Data';
    num h = lastUpdate?[0] ?? 0;
    num max = widget.data?.height ?? 1;

    Color color = Colors.red;

    if (h / max * 100 > 100) {
      color = Colors.purple;
    } else if (h / max * 100 > 80) {
      color = Colors.blue;
    } else if (h / max * 100 > 60) {
      color = Colors.green;
    } else if (h / max * 100 > 40) {
      color = Colors.yellow;
    } else if (h / max * 100 > 20) {
      color = Colors.orange;
    } else if (h / max * 100 > 0) {
      color = Colors.red;
    }

    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              widget.data?.thingName ?? 'No Name',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              if (h < 0) {
                h = 0;
              }
              return Column(
                children: [
                  CircularPercentIndicator(
                    radius: 50.0,
                    lineWidth: 15.0,
                    percent: h / max > 1 ? 1 : h / max,
                    center: Text(
                      '${(h / max * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 25),
                    ),
                    progressColor: color,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Consumer(builder: (context, ref, child) {
                          ref.watch(timeProvider);
                          return Text(t != 'No Data'
                              ? TimeAgoSinceNow().timeAgoSinceDate(t.toString())
                              : 'No Data');
                        }),
                      ),
                      IconButton(
                        onPressed: () => ref
                            .read(mqttServicesProvider)
                            .getCurrentData(widget.data!.serialNumber),
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
