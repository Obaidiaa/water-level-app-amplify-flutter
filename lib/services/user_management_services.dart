// import 'dart:async';

// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
// import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_view_model.dart';
// import 'package:water_level_flutter/app/settings_page/setting_page_model_view.dart';
// import 'package:water_level_flutter/models/Device.dart';
// import 'package:water_level_flutter/models/User.dart';

// final userManagementServicesProvider = Provider<UserManagementServices>((ref) {
//   return UserManagementServices(ref);
// });

// class UserManagementServices {
//   UserManagementServices(this.ref) {
//     StreamSubscription<HubEvent> hubSubscription =
//         Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
//       switch (hubEvent.eventName) {
//         case 'SIGNED_IN':
//           print('USER IS SIGNED IN');
//           ref.invalidate(settingPageModelViewProvider);
//           break;
//         case 'SIGNED_OUT':
//           print('USER IS SIGNED OUT');
//           break;
//         case 'SESSION_EXPIRED':
//           print('SESSION HAS EXPIRED');
//           break;
//         case 'USER_DELETED':
//           print('USER HAS BEEN DELETED');
//           break;
//       }
//     });
//   }

//   Ref ref;
//   Future<AsyncValue<User?>> getUser() async {
//     try {
//       final result = await Amplify.Auth.fetchUserAttributes();
//       Map re = {};
//       for (final element in result) {
//         print('key: ${element.userAttributeKey}; value: ${element.value}');
//         re[element.userAttributeKey.toString()] = element.value;
//       }
//       final user = User(
//           // userId: value.userId,
//           userName: re["sub"],
//           email: re["email"],
//           address: re["address"],
//           name: re["name"],
//           phone: re["phone"],
//           owner: re["sub"],
//           subscribeStart: re["custom:subscription_start"],
//           subscribeEnd: re["custom:subscription_end"]
//           // active: true,
//           );
//       return AsyncData(user);
//     } on AuthException catch (e) {
//       print(e.message);
//       return AsyncError("error", StackTrace.empty);
//     }
//   }

//   void disposeAll() {
//     ref.invalidate(deviceEditPageViewModelProvider);
//     ref.invalidate(deviceManagementViewModelProvider);
//     ref.invalidate(settingPageModelViewProvider);
//   }

//   Future<void> updateUserAttributes(User user) async {
//     final attributes = [
//       AuthUserAttribute(
//         userAttributeKey: CognitoUserAttributeKey.name,
//         value: user.name!,
//       ),
//       AuthUserAttribute(
//         userAttributeKey: CognitoUserAttributeKey.address,
//         value: user.address!,
//       ),
//       // AuthUserAttribute(
//       //   userAttributeKey: CognitoUserAttributeKey.phoneNumber,
//       //   value: user.phone!,
//       // ),
//     ];

//     try {
//       final result =
//           await Amplify.Auth.updateUserAttributes(attributes: attributes);
//       result.forEach((key, value) {
//         if (value.nextStep.updateAttributeStep ==
//             'CONFIRM_ATTRIBUTE_WITH_CODE') {
//           final destination = value.nextStep.codeDeliveryDetails?.destination;
//           print('Confirmation code sent to $destination for $key');
//         } else {
//           print('Update completed for $key');
//         }
//       });
//     } on AmplifyException catch (e) {
//       print(e.message);
//     }
//   }

//   void logoff() {
//     Amplify.Auth.signOut();
//     disposeAll();
//   }
// }
