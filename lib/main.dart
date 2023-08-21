import 'dart:ui';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:water_level_flutter/routing/app_router.dart';
// import 'package:amplify_datastore/amplify_datastore.dart';

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
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return Authenticator(
      child: MaterialApp.router(
        title: "Water Level BLE",
        builder: Authenticator.builder(),

        routerConfig: router,

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
