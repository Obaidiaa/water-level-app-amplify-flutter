import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:water_level_flutter/app/homepage/home_page.dart';
import 'package:water_level_flutter/routing/app_router.dart';

void main() {
  runApp(ProviderScope(overrides: [], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Water Level BLE",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: FormBuilderLocalizations.delegate.supportedLocales,
      onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
    );
  }
}
