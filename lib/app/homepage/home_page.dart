import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_page.dart';
import 'package:water_level_flutter/app/settings_page/setting_page_model_view.dart';
import 'package:water_level_flutter/services/datastore_services.dart';
import 'package:water_level_flutter/services/graphql_services.dart';
import 'package:water_level_flutter/services/mqtt_services.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                ref.watch(mqttStatusNotifier)!
                    ? Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              ref.refresh(mqttServicesProvider);
            },
            child: Text('Refresh')),
        ref.watch(deviceManagementViewModelProvider).when(
            data: (data) {
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${data[index]!.thingName}",
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              "76%",
                              style: TextStyle(fontSize: 25),
                            )
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
