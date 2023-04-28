// app routes

import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_page.dart';
import 'package:water_level_flutter/app/device_managment_page/devices_managment_page.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
import 'package:water_level_flutter/app/app_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const deviceSetupPage = '/device-setup-page';
  static const settingPage = '/setting-page';
  static const appPage = '/';
  static const devicePage = '/device-page';
  static const addDevicePage = '/add-device-page';
  static const loginPage = '/login-page';
  static const registerPage = '/register-page';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.appPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AppPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.deviceSetupPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const DeviceSetupPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.devicePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DevicePage(),
          settings: settings,
          // fullscreenDialog: true,
        );
      default:
        return null;
    }
  }
}
