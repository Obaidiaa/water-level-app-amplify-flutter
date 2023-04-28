import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/settings_page/setting_page_model_view.dart';
import 'package:water_level_flutter/services/datastore_services.dart';
import 'package:water_level_flutter/services/user_management_services.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.settings,
                    size: 25,
                  ),
                  Text(
                    'Settings',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
            ),
          ),
        ),
        // StreamBuilder(
        //   stream: ref.watch(userManagementServicesProvider).observeUser(),
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     return Container(
        //       child: Text('${snapshot.data}'),
        //     );
        //   },
        // ),

        ref.watch(settingPageModelViewProvider).when(
            data: (data) {
              String name = data.name;
              String address = data.address;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Card(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Name")),
                          initialValue: data.name,
                          onChanged: (value) => name = value,
                        ),
                      ),
                      // Card(
                      //   child: TextFormField(
                      //     decoration:
                      //         const InputDecoration(label: Text("Username")),
                      //     initialValue: data.userName,
                      //   ),
                      // ),
                      Card(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Email")),
                          initialValue: data.email,
                          enabled: false,
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Phone")),
                          initialValue: data.phone,
                          enabled: false,
                          // onChanged: (value) => data.phone = value,
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          decoration:
                              const InputDecoration(label: Text("Address")),
                          initialValue: data.address,
                          onChanged: (value) => address = value,
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('subscribe start'),
                          subtitle: Text('${data.subscribeStart}'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('subscribe end'),
                          subtitle: Text('${data.subscribeEnd}'),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final user = data.copyWith(
                            name: name,
                            address: address,
                          );
                          ref
                              .watch(settingPageModelViewProvider.notifier)
                              .update(user);
                        },
                        child: Text('Save'),
                      ),

                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(settingPageModelViewProvider.notifier)
                              .logoff();
                        },
                        child: Text('Logoff'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        // ref.read(dataStoreProvider).clearData(),
                        // ref.refresh(userData),
                        child: Text('Clear Cache'),
                      )
                    ],
                  ),
                ),
              );
            },
            error: ((error, stackTrace) => Text(error.toString())),
            loading: () => CircularProgressIndicator()),
      ],
    );
  }
}
