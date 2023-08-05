import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/homepage/application/devices_service.dart';
import 'package:water_level_flutter/services/mqtt_services.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool isInit = false;
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
                offset: Offset(0, 0.75), // changes position of shadow
              ),
            ],
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 100 * 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ac_unit_sharp,
                  size: 25,
                ),

                Text(
                  'Level',
                  style: TextStyle(fontSize: 25),
                ),

                // ref.watch(mqttStatusNotifier)!
                mqttStatus!
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          // ref.refresh(mqttServicesProvider);
                          ref.read(mqttServicesProvider).init();
                        },
                        child: Text('connect')),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () => ref.read(mqttServicesProvider).disconnect(),
            child: Text('disconnect')),
        state.when(
            data: (data) {
              if (!isInit) {
                ref.read(mqttServicesProvider).getAllDeviceData(data);
                isInit = true;
              }
              return Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.greenAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                data[index]?.serialNumber ?? 'No Name',
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final lastUpdate = ref.watch(devicesLevelData)[
                                    data[index]?.serialNumber];
                                final t = lastUpdate?[1] ?? 'No Data';
                                return Column(
                                  children: [
                                    Text(
                                      lastUpdate?[0].toString() ?? 'No Data',
                                      style: TextStyle(fontSize: 25),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('$t'),
                                        IconButton(
                                          onPressed: () => ref
                                              .read(mqttServicesProvider)
                                              .getCurrentData(
                                                  data[index]!.serialNumber),
                                          icon: Icon(Icons.refresh),
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
                    }),
              );
            },
            error: ((error, stackTrace) {
              return Text('Error $error');
            }),
            loading: (() => CircularProgressIndicator())),
      ],
    );
  }
}
