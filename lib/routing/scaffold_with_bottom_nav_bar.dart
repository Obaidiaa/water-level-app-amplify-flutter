import 'package:water_level_flutter/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This is a temporary implementation
// TODO: Implement a better solution once this PR is merged:
// https://github.com/flutter/packages/pull/2650
class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({Key? key, required this.child})
      : super(key: key);
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // used for the currentIndex argument of BottomNavigationBar
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      // If the tab hasn't changed, do nothing
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      // Note: this won't remember the previous state of the route
      // More info here:
      // https://github.com/flutter/flutter/issues/99124
      context.goNamed(AppRoute.home.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.devices.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.settings.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.child,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          items: const [
            // products
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
          onTap: (index) => _tap(context, index),
        ),
      ),
    );
  }
}
