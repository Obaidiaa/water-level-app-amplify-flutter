import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/services/auth_services.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>((ref) {
  final authServices = ref.read(authServicesProvider);
  return AuthNotifier(authServices);
});

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  AuthNotifier(this._authServices) : super(const AsyncData(null));

  final AuthServices _authServices;

  Future<void> fetchAuthSession() async {
    try {
      final result = await Amplify.Auth.fetchAuthSession();
      safePrint('identityId: $result');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  // Future<AsyncValue> signInUser(String username, String password) async {
  //   return _authServices.signInUser(username, password).then(
  //         (value) => value.when(
  //           data: (data) {
  //             state = AsyncData(data);
  //             return AsyncData(data);
  //           },
  //           error: (error, stackTrace) => AsyncError(error),
  //           loading: (() => const AsyncLoading()),
  //         ),
  //       );
  // }

  // signOutUser() {
  //   _authServices.signOutUser().then((value) => value.when(
  //       data: (data) {
  //         state = const AsyncError('Sign Out');
  //         print(state);
  //       },
  //       error: (error, trace) {},
  //       loading: () {}));
  // }
}
