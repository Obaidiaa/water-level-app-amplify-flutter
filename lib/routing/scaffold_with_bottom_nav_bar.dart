// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Stateful navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // if (size.width < 450) {
    return ScaffoldWithBottomNavBar(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
    // } else {
    //   return ScaffoldWithNavigationRail(
    //     body: navigationShell,
    //     currentIndex: navigationShell.currentIndex,
    //     onDestinationSelected: _goBranch,
    //   );
    // }
  }
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    super.key,
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: const [
          // products
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.device_hub),
            selectedIcon: Icon(Icons.device_hub_sharp),
            label: 'Devices',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

// class ScaffoldWithNavigationRail extends StatelessWidget {
//   const ScaffoldWithNavigationRail({
//     super.key,
//     required this.body,
//     required this.currentIndex,
//     required this.onDestinationSelected,
//   });
//   final Widget body;
//   final int currentIndex;
//   final ValueChanged<int> onDestinationSelected;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           NavigationRail(
//             selectedIndex: currentIndex,
//             onDestinationSelected: onDestinationSelected,
//             labelType: NavigationRailLabelType.all,
//             destinations: <NavigationRailDestination>[
//               NavigationRailDestination(
//                 icon: const Icon(Icons.work_outline),
//                 selectedIcon: const Icon(Icons.home),
//                 label: Text('Home'),
//               ),
//               NavigationRailDestination(
//                 icon: const Icon(Icons.device_hub),
//                 selectedIcon: const Icon(Icons.device_hub),
//                 label: Text('devices'),
//               ),
//               NavigationRailDestination(
//                 icon: const Icon(Icons.person_outline),
//                 selectedIcon: const Icon(Icons.person),
//                 label: Text('Settings'),
//               ),
//             ],
//           ),
//           const VerticalDivider(thickness: 1, width: 1),
//           // This is the main content.
//           Expanded(
//             child: body,
//           ),
//         ],
//       ),
//     );
//   }
// }
