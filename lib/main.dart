import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:water_level_flutter/app/app_page.dart';
import 'package:water_level_flutter/routing/app_router.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool amplifyConfigured = false;
  try {
    await _configureAmplify();
    amplifyConfigured = true;
  } catch (e) {
    print(e);
  }
  runApp(ProviderScope(
      overrides: [], child: MyApp(amplifyConfigured: amplifyConfigured)));
}

Future<void> _configureAmplify() async {
  final api = AmplifyAPI(modelProvider: ModelProvider.instance);
  await Amplify.addPlugin(api); // UNCOMMENT this line after backend is deployed
  final auth = AmplifyAuthCognito();

  await Amplify.addPlugins([
    // AmplifyDataStore(
    //   modelProvider: ModelProvider.instance,
    // ),
    auth
  ]);

  // Once Plugins are added, configure Amplify
  await Amplify.configure(amplifyconfig);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.amplifyConfigured}) : super(key: key);

  final bool amplifyConfigured;
  @override
  Widget build(BuildContext context) {
    if (!amplifyConfigured) {
      return Authenticator(
          child: MaterialApp(
        title: "Water Level BLE",
        builder: Authenticator.builder(),
        home: SafeArea(
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text('Amplify Not configured'),
                )
              ],
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
      ));
    } else {
      return Authenticator(
        child: MaterialApp(
          title: "Water Level BLE",
          home: AppPage(),
          builder: Authenticator.builder(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
          ],
          // supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        ),
      );
    }
  }
}
