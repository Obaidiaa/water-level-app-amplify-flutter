// // app routes
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_page/device_edit_page.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/devices_managment_page.dart';
import 'package:water_level_flutter/app/homepage/presentation/home_page.dart';
import 'package:water_level_flutter/app/settings_page/setting_page.dart';
import 'package:water_level_flutter/routing/scaffold_with_bottom_nav_bar.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _devicesNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'devices');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

enum AppRoute {
  home,
  settings,
  devices,
  addDevcie,
  editDevice,
}

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: AppRoute.home.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _devicesNavigatorKey,
            routes: [
              GoRoute(
                path: '/devices',
                name: AppRoute.devices.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DevicesManagmentPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'devices/edit',
                    name: AppRoute.editDevice.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      final device = state.extra as Device;
                      return MaterialPage(
                        fullscreenDialog: true,
                        child: DeviceEditPage(
                          device: device,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                name: AppRoute.settings.name,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SettingPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
