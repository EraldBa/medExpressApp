import 'package:flutter/material.dart';

import 'package:med_express/app/home/models/destinations.dart';

class MyNavBar extends StatelessWidget {
  final List<Destination> destinations;
  final void Function(int) onTap;
  final int currentIndex;

  const MyNavBar({
    super.key,
    required this.currentIndex,
    required this.destinations,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 8.0,
      child: NavigationBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        destinations: destinations.map((e) {
          return NavigationDestination(
            icon: e.iconWrapped,
            selectedIcon: e.selectedIconWrapped,
            label: e.label,
          );
        }).toList(),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        elevation: 0.0,
      ),
    );
  }
}
