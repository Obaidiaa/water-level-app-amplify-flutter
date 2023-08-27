import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/app/homepage/presentation/home_page_controller.dart';
import 'package:water_level_flutter/packages/time_ago_since_now.dart';
import 'package:water_level_flutter/services/mqtt_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      Icons.ac_unit_sharp,
                      // size: 35.sp,
                      size: Theme.of(context).textTheme.titleMedium!.fontSize,
                    ),
                    Text(
                      'Level',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),

                // ref.watch(mqttStatusNotifier)!

                Padding(
                  padding: EdgeInsets.only(right: 20.0.sp),
                  child: mqttStatus! == 1
                      ? const CircularProgressIndicator()
                      : mqttStatus == 2
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
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
            if (mqttStatus == 2) {
              ref.read(mqttServicesProvider).getAllDeviceData(data);
            }
            return Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Color levelColor = Colors.red;
                    return Padding(
                      padding: EdgeInsets.only(top: 8.0.sp),
                      child: LevelCard(data: data[index] as Device),
                    );
                  }),
            );
          },
          error: ((error, stackTrace) {
            return Text('Error $error');
          }),
          loading: (() => const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )),
        ),
      ],
    );
  }
}

final timeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

class LevelCard extends HookConsumerWidget {
  const LevelCard({
    required this.data,
    super.key,
  });
  final Device data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The controller for the animation.
    AnimationController cardController = useAnimationController(
        duration: const Duration(milliseconds: 500), initialValue: 1);
    Animation animation = Tween(end: 0.0, begin: 1.0).animate(cardController);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      ref.read(timeProvider.notifier).state = DateTime.now();
    });

    final lastUpdate = ref.watch(devicesLevelData)[data.serialNumber];
    final t = lastUpdate?[1] ?? 'No Data';
    num h = lastUpdate?[0] ?? 0;
    num max = data.height ?? 1;

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

    return InkWell(
      onTap: () async {
        if (cardController.isCompleted) {
          await cardController.reverse();
        } else {
          await cardController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: cardController,
        builder: (BuildContext context, Widget? child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateY(3.14 * animation.value),
            alignment: FractionalOffset.center,
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: animation.value >= 0.5
                    ? Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0015)
                          ..rotateY(3.14),
                        alignment: FractionalOffset.center,
                        child: Card(
                          elevation: 5,
                          child: Flex(
                            direction: Axis.vertical,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5.sp),
                                  child: FittedBox(
                                    child: Text(
                                      data.thingName ?? 'No Name',
                                      // overflow: TextOverflow.ellipsis,
                                      // style: TextStyle(
                                      // fontSize: Theme.of(context)
                                      //     .textTheme
                                      //     .titleMedium!
                                      //     .fontSize,
                                      // ),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(data.location ?? ''),
                              ),
                              Center(
                                child: Text(
                                  data.serialNumber,
                                  // style: TextStyle(
                                  //   fontSize: 15.sp,
                                  // ),
                                ),
                              ),
                              Text(
                                '${h.toStringAsFixed(2)} CM / ${max.toStringAsFixed(2)} CM',
                                // style: TextStyle(fontSize: 15.sp),
                              ),
                              Text(
                                'Last Update:  $t',
                                // style: TextStyle(fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Card(
                        elevation: 5,
                        child: Flex(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          direction: Axis.vertical,
                          children: [
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Text(
                                          data.thingName ?? 'No Name',
                                          overflow: TextOverflow.ellipsis,
                                          // style: TextStyle(
                                          //   fontSize: 18.sp,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.history,
                                      // size: 18.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 6,
                              child: FittedBox(
                                child: CircularPercentIndicator(
                                  radius: 45,
                                  animation: true,
                                  lineWidth: 15.0,
                                  percent: h / max > 1
                                      ? 1
                                      : h / max < 0
                                          ? 0
                                          : h / max,
                                  center: Text(
                                    '${(h / max * 100).toStringAsFixed(0)}%',
                                    style: const TextStyle(fontSize: 25),
                                  ),
                                  progressColor: color,
                                ),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.tight,
                              flex: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Consumer(builder: (context, ref, child) {
                                    ref.watch(timeProvider);
                                    return Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: Text(
                                        t != 'No Data'
                                            ? TimeAgoSinceNow()
                                                .timeAgoSinceDate(t.toString())
                                            : 'No Data',
                                        overflow: TextOverflow.ellipsis,
                                        // style: TextStyle(fontSize: 12.sp),
                                      ),
                                    );
                                  }),
                                  IconButton(
                                    onPressed: () => ref
                                        .read(mqttServicesProvider)
                                        .getCurrentData(data.serialNumber),
                                    icon: const Icon(
                                      Icons.refresh,
                                      // size: 25.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
          );
        },
      ),
    );
  }
}
