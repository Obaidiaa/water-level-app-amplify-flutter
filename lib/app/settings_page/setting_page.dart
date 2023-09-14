import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/settings_page/data/settings_repository.dart';
import 'package:water_level_flutter/app/settings_page/setting_page_controller.dart';
import 'package:water_level_flutter/app/util/async_value_ui.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingPageState();
}

Future<void> signOutCurrentUser() async {
  final result = await Amplify.Auth.signOut();
  if (result is CognitoCompleteSignOut) {
    safePrint('Sign out completed successfully');
  } else if (result is CognitoFailedSignOut) {
    safePrint('Error signing user out: ${result.exception.message}');
  }
}

class _SettingPageState extends ConsumerState<SettingPage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   ref
  //       .read(settingPageControllerProvider.notifier)
  //       .fetchCurrentUserAttributes();
  // }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      settingPageControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    // final state = ref.watch(settingPageControllerProvider);
    final state = ref.watch(fetchCurrentUserAttributesFutureProvider);
    return Scaffold(
      appBar: AppBar(
        // leading: const Icon(
        //   Icons.settings,
        // ),
        title: const Center(
          child: Text(
            'Settings',
          ),
        ),
      ),
      body: Column(
        children: [
          state.when(
            data: (data) {
              // String name = data[0].value ?? '';
              // String address = data[1].value ?? '';
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      ...data.map((e) {
                        return ListTile(
                          title: Text(e.userAttributeKey.key),
                          subtitle: Text(e.value),
                        );
                      }),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     // final result = await ref
                      //     //     .read(settingPageControllerProvider.notifier)
                      //     //     .updateCurrentUserAttributes(name, address);
                      //     // if (result) {
                      //     //   ScaffoldMessenger.of(context).showSnackBar(
                      //     //     const SnackBar(
                      //     //       content: Text('Updated Successfully'),
                      //     //     ),
                      //     //   );
                      //     // } else {
                      //     //   ScaffoldMessenger.of(context).showSnackBar(
                      //     //     const SnackBar(
                      //     //       content: Text('Error Updating'),
                      //     //     ),
                      //     //   );
                      //     // }
                      //   },
                      //   child: const Text('Update'),
                      // ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (error, stackTrace) => Center(
              child: Text(
                error.toString(),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => signOutCurrentUser(), child: Text('Sign Out')),
          // StreamBuilder(
          //   stream: ref.watch(userManagementServicesProvider).observeUser(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     return Container(
          //       child: Text('${snapshot.data}'),
          //     );
          //   },
          // ),

          // ref.watch(settingPageModelViewProvider).when(
          //     data: (data) {
          //       String name = data.name;
          //       String address = data.address;
          //       return Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: ListView(
          //             children: [
          //               Card(
          //                 child: TextFormField(
          //                   decoration:
          //                       const InputDecoration(label: Text("Name")),
          //                   initialValue: data.name,
          //                   onChanged: (value) => name = value,
          //                 ),
          //               ),
          //               // Card(
          //               //   child: TextFormField(
          //               //     decoration:
          //               //         const InputDecoration(label: Text("Username")),
          //               //     initialValue: data.userName,
          //               //   ),
          //               // ),
          //               Card(
          //                 child: TextFormField(
          //                   decoration:
          //                       const InputDecoration(label: Text("Email")),
          //                   initialValue: data.email,
          //                   enabled: false,
          //                 ),
          //               ),
          //               Card(
          //                 child: TextFormField(
          //                   decoration:
          //                       const InputDecoration(label: Text("Phone")),
          //                   initialValue: data.phone,
          //                   enabled: false,
          //                   // onChanged: (value) => data.phone = value,
          //                 ),
          //               ),
          //               Card(
          //                 child: TextFormField(
          //                   decoration:
          //                       const InputDecoration(label: Text("Address")),
          //                   initialValue: data.address,
          //                   onChanged: (value) => address = value,
          //                 ),
          //               ),
          //               Card(
          //                 child: ListTile(
          //                   title: Text('subscribe start'),
          //                   subtitle: Text('${data.subscribeStart}'),
          //                 ),
          //               ),
          //               Card(
          //                 child: ListTile(
          //                   title: Text('subscribe end'),
          //                   subtitle: Text('${data.subscribeEnd}'),
          //                 ),
          //               ),
          //               ElevatedButton(
          //                 onPressed: () {
          //                   final user = data.copyWith(
          //                     name: name,
          //                     address: address,
          //                   );
          //                   // ref
          //                   //     .watch(settingPageModelViewProvider.notifier)
          //                   //     .update(user);
          //                 },
          //                 child: Text('Save'),
          //               ),

          //               ElevatedButton(
          //                 onPressed: () {
          //                   // ref
          //                   //     .read(settingPageModelViewProvider.notifier)
          //                   //     .logoff();
          //                 },
          //                 child: Text('Logoff'),
          //               ),
          //               ElevatedButton(
          //                 onPressed: () {},
          //                 // ref.read(dataStoreProvider).clearData(),
          //                 // ref.refresh(userData),
          //                 child: Text('Clear Cache'),
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //     error: ((error, stackTrace) => Text(error.toString())),
          //     loading: () => CircularProgressIndicator()),
        ],
      ),
    );
  }
}
