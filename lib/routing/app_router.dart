// // app routes
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:water_level_flutter/app/device_managment_page/domain/Device.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/device_page/device_edit_page.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/devices_managment_page.dart';
import 'package:water_level_flutter/app/homepage/presentation/home_page.dart';
import 'package:water_level_flutter/app/settings_page/setting_page.dart';
import 'package:water_level_flutter/app/widgets/devices_list.dart';
import 'package:water_level_flutter/routing/go_router_refresh_stream.dart';
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
  // final authRepository = ref.watch(authRepositoryProvider);
  // final onboardingRepository = ref.watch(onboardingRepositoryProvider);
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    //   // final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
    //   // if (!didCompleteOnboarding) {
    //   //   // Always check state.subloc before returning a non-null route
    //   //   // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
    //   //   if (state.subloc != '/onboarding') {
    //   //     return '/onboarding';
    //   //   }
    //   // }
    //   final isLoggedIn = authRepository.currentUser != null;
    //   // print(authRepository.currentUser!.uid);
    //   if (isLoggedIn) {
    //     if (state.subloc.startsWith('/signIn')) {
    //       return '/announcements';
    //     }
    //   } else {
    //     return '/signIn';
    //   }
    // },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      // GoRoute(
      //   path: '/signIn',
      //   name: AppRoute.signIn.name,
      //   pageBuilder: (context, state) => NoTransitionPage(
      //     key: state.pageKey,
      //     child: LoginPage(),
      //   ),
      // ),

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

      //   ShellRoute(
      //     navigatorKey: _shellNavigatorKey,
      //     builder: (context, state, child) {
      //       return ScaffoldWithBottomNavBar(child: child);
      //     },
      //     routes: [
      //       GoRoute(
      //         path: '/devices',
      //         name: AppRoute.devices.name,
      //         pageBuilder: (context, state) => NoTransitionPage(
      //           key: state.pageKey,
      //           child: const DevicesManagmentPage(),
      //         ),
      //         routes: [
      //           GoRoute(
      //             path: 'devices/edit',
      //             name: AppRoute.editDevice.name,
      //             parentNavigatorKey: _shellNavigatorKey,
      //             pageBuilder: (context, state) {
      //               final device = state.extra as Device;
      //               return MaterialPage(
      //                 key: state.pageKey,
      //                 fullscreenDialog: true,
      //                 child: DeviceEditPage(
      //                   device: device,
      //                 ),
      //               );
      //             },
      //           ),
      //           // GoRoute(
      //           //   path: 'announcement/:id',
      //           //   name: AppRoute.editDevice.name,
      //           //   parentNavigatorKey: _shellNavigatorKey,
      //           //   pageBuilder: (context, state) {
      //           //     final announcement = state.extra as Device;
      //           //     final id = state.params['id']!;
      //           //     return MaterialPage(
      //           //       key: state.pageKey,
      //           //       child: DeviceEditPage(
      //           //         id: id,
      //           //         announcement: announcement,
      //           //       ),
      //           //     );
      //           //   },
      //           // ),
      //         ],
      //       ),
      //       GoRoute(
      //         path: '/',
      //         name: AppRoute.home.name,
      //         pageBuilder: (context, state) => NoTransitionPage(
      //           key: state.pageKey,
      //           child: const HomePage(),
      //         ),
      //       ),
      //       GoRoute(
      //         path: '/settings',
      //         name: AppRoute.settings.name,
      //         pageBuilder: (context, state) => NoTransitionPage(
      //           key: state.pageKey,
      //           child: const SettingPage(),
      //         ),
      //       ),
      //     ],
      //   ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}

// import 'package:water_level_flutter/app/device_managment_page/device_page/device_edit_page.dart';
// import 'package:water_level_flutter/app/device_managment_page/devices_managment_page.dart';
// import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
// import 'package:water_level_flutter/app/app_page.dart';
// import 'package:flutter/material.dart';

// class AppRoutes {
//   static const deviceSetupPage = '/device-setup-page';
//   static const settingPage = '/setting-page';
//   static const appPage = '/';
//   static const devicePage = '/device-page';
//   static const addDevicePage = '/add-device-page';
//   static const loginPage = '/login-page';
//   static const registerPage = '/register-page';
// }

// class AppRouter {
//   static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
//     final args = settings.arguments;
//     switch (settings.name) {
//       case AppRoutes.appPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => AppPage(),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       case AppRoutes.deviceSetupPage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => const DeviceSetupPage(),
//           settings: settings,
//           fullscreenDialog: true,
//         );
//       case AppRoutes.devicePage:
//         return MaterialPageRoute<dynamic>(
//           builder: (_) => DevicePage(),
//           settings: settings,
//           // fullscreenDialog: true,
//         );
//       default:
//         return null;
//     }
//   }
// }
