import 'dart:async';
import 'dart:ffi';

import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/models/Device.dart';
import 'package:water_level_flutter/models/ModelProvider.dart';
import 'package:water_level_flutter/services/auth_services.dart';
import 'package:water_level_flutter/services/device_management_notifier.dart';
import 'package:water_level_flutter/services/device_managment_services.dart';

final dataStoreProvider = Provider<DataStoreSerives>((ref) {
  return DataStoreSerives(ref);
});

// final deviceListProvider = StreamProvider<List<Device>>((ref) {
//   return ref.watch(dataStoreProvider.notifier).d;
// });

// final deviceManagementServicesProvider =
//     Provider<DeviceManagementServices>((ref) {
//   return DeviceManagementServices(ref);
// });

// class DeviceManagementServices {
//   DeviceManagementServices(this.ref) {
//     // listenChanges();
//   }

//   Ref ref;

//   Future<List<Device>> getDevices() async {
//     try {
//       List<Device> devices = await Amplify.DataStore.query(Device.classType);

//       // state = devices;
//       return devices;
//       print('gettted devicefesgfds');
//       // return devices;
//     } catch (e) {
//       print("Could not query DataStore: $e");
//     }
//     return [];
//   }
// }

class DataStoreSerives {
  DataStoreSerives(this.ref) {
    // listenChanges();
  }

  Ref ref;

  Future<void> addUser() async {
    try {
      ref.read(authServicesProvider).getCurrentUser().then((value) async {
        // final user = User(
        //     // userId: value.userId,
        //     userName: value.username,
        //     email: value.username,
        //     address: 'Jeddah',
        //     name: 'Abdulrhman Obaidi',
        //     phone: '0563697000',
        //     owner: ''
        //     // active: true,
        //     );
        // await Amplify.DataStore.save(user);
      });
    } catch (e) {
      print("Error adding device $e");
    }
  }

  Future<void> updateUser(List<Device>? devices) async {
    ref.read(authServicesProvider).getCurrentUser().then((value) async {
      // final user = User(
      //   // userId: value.userId,
      //   userName: value.username,
      //   // devices: devices,
      //   // active: true,
      //   id: value.userId,
      //   owner: '',
      // );
      // await Amplify.DataStore.save(user);
    });

    // print(await getUser());
  }

  clearData() async {
    await Amplify.DataStore.clear()
        .then((value) => ref.refresh(deviceManagementServicesProvider));
  }

  // Future<List<User>> getUser() async {
  //   try {
  //     List<User> user = await Amplify.DataStore.query(User.classType);
  //     print(user.first.toJson());
  //     return user;
  //   } catch (e) {
  //     print("Could not query DataStore: $e");
  //   }
  //   return [];
  // }

  Stream<List<Device>> d = Amplify.DataStore.query(Device.classType).asStream();

  // void stopListeningChanges() {
  //   stream?.cancel();
  // }
}
