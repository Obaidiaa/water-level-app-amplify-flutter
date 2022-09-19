// app routes

import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
import 'package:water_level_flutter/app/homepage/home_page.dart';

import '';
import 'package:flutter/material.dart';

class AppRoutes {
  static const deviceSetupPage = '/device-setup-page';
  static const settingPage = '/setting-page';
  static const homePage = '/';
}

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.homePage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomePage(),
          settings: settings,
          fullscreenDialog: true,
        );
      case AppRoutes.deviceSetupPage:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DeviceSetupPage(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return null;
    }
  }
}
