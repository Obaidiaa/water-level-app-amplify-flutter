import 'package:flutter/material.dart';
import 'package:water_level_flutter/app/device_setup/device_setup_page.dart';
import 'package:water_level_flutter/routing/app_router.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true).pushNamed(
      AppRoutes.homePage,
      // arguments: settings,
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () => DeviceSetupPage.show(context),
                  child: Text('Device Setup')),
            ),
          ],
        ),
      ),
    );
  }
}
