import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:water_level_flutter/amplifyconfiguration.dart';
import 'package:water_level_flutter/models/Device.dart';
import 'package:water_level_flutter/services/auth_services.dart';

import '../models/ModelProvider.dart';

final amplifyServicesProvider = Provider<AmplifyServices>((ref) {
  return AmplifyServices(ref);
});

// final getDevices = FutureProvider<List<Device>>((ref) async {
//   return ref.watch(amplifyServicesProvider).getDevices();
// });

// final addDevice
class AmplifyServices {
  AmplifyServices(this.ref);

  Ref ref;

  Future<void> deletePostsWithId() async {
    final oldPosts = await Amplify.DataStore.query(
      Device.classType,
      // where: Device.ID.eq('123'),
    );
    // Query can return more than one posts with a different predicate
    // For this example, it is ensured that it will return one post
    final oldPost = oldPosts.first;
    try {
      await Amplify.DataStore.delete(oldPost);
      print('Deleted a post');
    } on DataStoreException catch (e) {
      print('Delete failed: $e');
    }
  }
}
