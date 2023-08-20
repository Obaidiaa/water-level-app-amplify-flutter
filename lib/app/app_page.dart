import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/presentation/devices_managment_page.dart';
import 'package:water_level_flutter/app/homepage/presentation/home_page.dart';
import 'package:water_level_flutter/app/settings_page/setting_page.dart';

class AppPage extends ConsumerStatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AppPage> createState() => _AppPageState();
}

class _AppPageState extends ConsumerState<AppPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DevicesManagmentPage(),
    SettingPage()
  ];

  void _onItemTapped(int index) {
    controller.animateToPage(index,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    _selectedIndex = index;
  }

  PageController controller = PageController();
  double? currentPageValue = 0.0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
        _selectedIndex = controller.page!.toInt();
      });
    });
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          itemBuilder: (context, index) => Center(
            child: _widgetOptions.elementAt(index),
          ),
          itemCount: 3,
          controller: controller,
          // onPageChanged: (index) {
          //   setState(() {
          //     print(index);
          //     _selectedIndex = index;
          //   });
          // },
          // children:
          // mainAxisAlignment: MainAxisAlignment.end,
          // [

          // TextButton(
          //     onPressed: () {
          //       ref.read(authServicesProvider).signOutUser();
          //     },
          //     child: const Text('Logout')),
          // DevicesList(),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: (() {
          //       ref.watch(amplifyServicesProvider).addDevice();
          //     }),
          //     child: Text('Add'),
          //   ),
          // ),
          // Center(
          //   child: ElevatedButton(
          //     onPressed: (() {
          //       ref.watch(amplifyServicesProvider).deletePostsWithId();
          //     }),
          //     child: Text('Delete'),
          //   ),
          // ),
          // Center(
          //   child: ElevatedButton(
          //       onPressed: () => DeviceSetupPage.show(context),
          //       child: Text('Device Setup')),
          // ),
          // ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.device_hub_sharp),
              label: 'Devices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),

        // } else {
        //   return LoginPage();
        // }
      ),
    );
  }
}
