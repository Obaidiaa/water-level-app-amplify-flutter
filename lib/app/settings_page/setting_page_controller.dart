import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/data/device_repository.dart';
import 'package:water_level_flutter/app/settings_page/data/settings_repository.dart';

part 'setting_page_controller.g.dart';

@riverpod
class SettingPageController extends _$SettingPageController {
  // Add your state and logic here
  @override
  FutureOr<void> build() async {
    print('build');
    // fetchCurrentUserAttributes();
  }

  // Future<List<AuthUserAttribute>> fetchCurrentUserAttributes() async {
  //   final repository = ref.read(settingsRepositoryProvider);
  //   state =
  //       await AsyncValue.guard(() => repository.fetchCurrentUserAttributes());

  //   return state.hasError == false;
  // }

  // Future updateCurrentUserAttributes(
  //     {required String name, required String address}) async {
  //   final repository = ref.read(settingsRepositoryProvider);
  //   state = await AsyncValue.guard(
  //       () => repository.updateCurrentUserAttributes(name, address));

  //   return state.hasError == false;
  // }
}
