// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/models/ModelProvider.dart';
// import 'package:water_level_flutter/app/auth/domain/User.dart';
// import 'package:water_level_flutter/services/datastore_services.dart';
// import 'package:water_level_flutter/services/user_management_services.dart';

// final settingPageModelViewProvider =
//     StateNotifierProvider<SettingPageModelView, AsyncValue>(
//         ((ref) => SettingPageModelView(ref)));

// // final userData = FutureProvider<AsyncValue<User>>((ref) async {
// //   final user = ref.watch(settingPageModelViewProvider);
// //   print(user);
// //   return AsyncValue(user);
// // });

// class SettingPageModelView extends StateNotifier<AsyncValue> {
//   SettingPageModelView(this.ref) : super(AsyncLoading()) {
//     _init();
//     // listenChanges();
//   }

//   // Ref ref;
//   // void _init() async {
//   //   state = const AsyncLoading();
//   //   AsyncValue user = await ref.read(userManagementServicesProvider).getUser();
//   //   // if (user.value.isEmpty) {
//   //   //   state = AsyncError("no data");
//   //   // } else {
//   //   state = user;
//   // }

//   // update(User user) {
//   //   print(user);
//   //   ref.read(userManagementServicesProvider).updateUserAttributes(user);
//   // }

//   // logoff() {
//   //   ref.read(userManagementServicesProvider).logoff();
//   // }
// }
