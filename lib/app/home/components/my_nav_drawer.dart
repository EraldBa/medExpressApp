import 'package:flutter/material.dart';

import 'package:med_express/app/app.dart';
import 'package:med_express/app/home/models/destinations.dart';
import 'package:med_express/services/user.dart';

class MyNavDrawer extends StatelessWidget {
  static const SizedBox _heightBox = SizedBox(height: 20.0);
  static const SizedBox _widthBox = SizedBox(width: 20.0);

  final List<Destination> destinations;
  final void Function(int) onTap;
  final int currentIndex;

  const MyNavDrawer({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Column(
            children: [
              _heightBox,
              Row(
                children: [
                  _widthBox,
                  const Icon(Icons.person),
                  _widthBox,
                  Text(
                    User.current.username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              _heightBox,
            ],
          ),
        ),
        _heightBox,
        const Text(
          '${App.name} Pages',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Divider(),
        _heightBox,
        ...destinations.map(
          (e) => NavigationDrawerDestination(
            icon: e.iconWrapped,
            selectedIcon: e.selectedIconWrapped,
            label: e.labelWrapped,
          ),
        )
      ],
    );
  }
}
