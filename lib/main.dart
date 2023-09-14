import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// Amplify Flutter Packages
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:water_level_flutter/routing/app_router.dart';
// import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:device_preview/device_preview.dart';
// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // try {
  await _configureAmplify();
  // } catch (e) {
  //   safePrint(e);
  // }
  // runApp(
  //   ProviderScope(
  //     overrides: [],
  //     child: MyApp(amplifyConfigured: amplifyConfigured),
  //   ),
  // );

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers();
  // * Entry point of the app

  final container = ProviderContainer(
    overrides: [],
  );
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => UncontrolledProviderScope(
        container: container,
        child: MyApp(savedThemeMode),
      ),
    ),
  );
}

Future<void> _configureAmplify() async {
  await Amplify.addPlugin(AmplifyAuthCognito());
  await Amplify.addPlugin(AmplifyAPI(modelProvider: ModelProvider.instance));

  await Amplify.addPlugins([
    // AmplifyDataStore(
    //   modelProvider: ModelProvider.instance,
    // ),
    // auth
  ]);

  // Once Plugins are added, configure Amplify
  await Amplify.configure(amplifyconfig);
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await _configureAmplify();
//   runApp(const MyApp(
//     amplifyConfigured: true,
//   ));
// }

// Future<void> _configureAmplify() async {
//   try {
//     // Create the API plugin.
//     //
//     // If `ModelProvider.instance` is not available, try running
//     // `amplify codegen models` from the root of your project.
//     final api = AmplifyAPI(modelProvider: ModelProvider.instance);

//     // Create the Auth plugin.
//     final auth = AmplifyAuthCognito();

//     // Add the plugins and configure Amplify for your app.
//     await Amplify.addPlugins([api, auth]);
//     await Amplify.configure(amplifyconfig);

//     safePrint('Successfully configured');
//   } on Exception catch (e) {
//     safePrint('Error configuring Amplify: $e');
//   }
// }

class MyApp extends HookConsumerWidget {
  const MyApp(this.savedThemeMode, {Key? key}) : super(key: key);

  final savedThemeMode;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // AdaptiveTheme.of(context).setSystem();
    return Authenticator(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (context, child) => MaterialApp.router(
          title: "Water Level BLE",
          builder: Authenticator.builder(),

          routerConfig: router,
          theme: ThemeData(
            useMaterial3: true,
            // Define the default brightness and colors.
            brightness: savedThemeMode,
            // primaryColor: isDarkMode ? Colors.grey[800] : Colors.white,

            // Define the default font family.
            fontFamily: 'Roboto',

            // Define the default `TextTheme`. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              displayLarge:
                  TextStyle(fontSize: 72.sp, fontWeight: FontWeight.bold),
              titleLarge: TextStyle(fontSize: 36.sp),
              displayMedium: TextStyle(fontSize: 60.sp, fontFamily: 'Roboto'),
              titleMedium: TextStyle(fontSize: 24.sp, fontFamily: 'Roboto'),
              displaySmall: TextStyle(fontSize: 30.sp, fontFamily: 'Roboto'),
              titleSmall: TextStyle(fontSize: 18.sp, fontFamily: 'Roboto'),
              bodyLarge: TextStyle(fontSize: 18.sp, fontFamily: 'Roboto'),
              bodyMedium: TextStyle(fontSize: 14.sp, fontFamily: 'Roboto'),
            ),
            // iconTheme: IconThemeData(
            //   color: isDarkMode ? Colors.white : Colors.grey[800],
            //   size: 20.sp,
            // ),
          ),
          // home: SafeArea(
          //   child: Scaffold(
          //     body: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: const [
          //         Center(
          //           child: Text('Amplify Not configured'),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

    // return Authenticator(
    //   child: MaterialApp(
    //     title: "Water Level BLE",
    //     home: AppPage(),
    //     builder: Authenticator.builder(),
    //     debugShowCheckedModeBanner: false,
    //     localizationsDelegates: const [
    //       FormBuilderLocalizations.delegate,
    //     ],
    //   ),
    // );
  }
}
// }

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      ),
    );
  };
}
