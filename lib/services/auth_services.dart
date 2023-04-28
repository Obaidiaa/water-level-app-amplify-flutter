import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider<AuthServices>((ref) {
  return AuthServices();
});

// final isUserSignedIn = FutureProvider<bool>((ref) async {
//   return ref.read(authServicesProvider).isUserSignedIn();
// });

final getCurrentUser = FutureProvider<AuthUser>((ref) async {
  final currentuser = ref.read(authServicesProvider).getCurrentUser();
  return currentuser;
});

class AuthServices {
  // Future<bool> isUserSignedIn() async {
  //   final result = await Amplify.Auth.fetchAuthSession();
  //   print(result.isSignedIn);
  //   return result.isSignedIn;
  // }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    // print(user.userId);
    return user;
  }

// Create a boolean for checking the sign in status
// bool isSignedIn = false;

//   Future<AsyncValue> signInUser(String username, String password) async {
//     try {
//       final result = await Amplify.Auth.signIn(
//         username: username,
//         password: password,
//       );
//       // setState(() {
//       isSignedIn = result.isSignedIn;
//       print('$username $password $isSignedIn');

//       return AsyncData(result.isSignedIn.toString());
//       // });
//     } on UserNotConfirmedException catch (e) {
//       return AsyncError({'Success': false, 'Message': '${e.message}'});
//     } on AuthException catch (e) {
//       safePrint(e.message);
//       return AsyncError({'Success': false, 'Message': '${e.message}'});
//     }
//   }

  Future<AsyncValue> signOutUser() async {
    try {
      final result = await Amplify.Auth.signOut();
      return AsyncData(result);
    } catch (e) {
      return AsyncError('$e', StackTrace.empty);
    }
  }
}
// }

// final registerUserProvider = Provider<RegisterUser>((ref) {
//   return RegisterUser();
// });

// class RegisterUser {
//   // Create a boolean for checking the sign up status
//   bool isSignUpComplete = false;

//   Future<Map<String, dynamic>> signUpUser(String email, String password,
//       String name, String phone, String city) async {
//     try {
//       final userAttributes = <CognitoUserAttributeKey, String>{
//         CognitoUserAttributeKey.email: email,
//         CognitoUserAttributeKey.phoneNumber: '+966${phone.substring(1)}',
//         CognitoUserAttributeKey.name: name,
//         CognitoUserAttributeKey.address: city,
//         // additional attributes as needed
//       };
//       final result = await Amplify.Auth.signUp(
//         username: email,
//         password: password,
//         options: CognitoSignUpOptions(userAttributes: userAttributes),
//       );
//       isSignUpComplete = result.isSignUpComplete;
//       return {'Success': isSignUpComplete, 'Message': 'succesed'};
//     } on AuthException catch (e) {
//       safePrint(e.message);
//       return {'Success': false, 'Message': '${e.message}'};
//     }
//   }

//   Future<Map<String, dynamic>> confirmUser(String email, String code) async {
//     try {
//       final result = await Amplify.Auth.confirmSignUp(
//           username: email, confirmationCode: code);

//       // setState(() {
//       isSignUpComplete = result.isSignUpComplete;
//       // });r
//       return {'Success': isSignUpComplete, 'Message': 'succesed'};
//     } on AuthException catch (e) {
//       safePrint(e.message);
//       return {'Success': false, 'Message': '${e.message}'};
//     }
//   }
// }
