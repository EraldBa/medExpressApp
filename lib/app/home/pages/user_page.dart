import 'package:flutter/material.dart';

import 'package:med_express/mixins/adaptive_mixin.dart';
import 'package:med_express/app/home/pages/account_page.dart';
import 'package:med_express/app/home/components/my_nav_bar.dart';
import 'package:med_express/app/home/components/my_nav_drawer.dart';
import 'package:med_express/app/home/components/search_bar.dart';
import 'package:med_express/app/home/models/destinations.dart';
import 'package:med_express/app/home/pages/search_page.dart';
import 'package:med_express/app/home/pages/settings_page.dart';
import 'package:med_express/services/user.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  static String get route => '/user_page';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with AdaptiveScreenMixin {
  static const List<Destination> _destinations = [
    Destination(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    Destination(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  static const List<Widget> _userPageList = [
    SearchPage(),
    AccountPage(),
    SettingsPage(),
  ];

  int _currentIndex = 0;

  Widget? get _getNavDrawer {
    return isBigScreen(context)
        ? MyNavDrawer(
            currentIndex: _currentIndex,
            onTap: (index) {
              _setCurrentIndex(index);
              Navigator.of(context).pop();
            },
            destinations: _destinations,
          )
        : null;
  }

  Widget? get _getNavBar {
    return isSmallScreen(context)
        ? MyNavBar(
            currentIndex: _currentIndex,
            destinations: _destinations,
            onTap: _setCurrentIndex,
          )
        : null;
  }

  void _setCurrentIndex(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_destinations[_currentIndex].label),
        actions: [
          IconButton(
            onPressed: () => User.current.logOut(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: _getNavDrawer,
      body: _userPageList[_currentIndex],
      bottomNavigationBar: _getNavBar,
      floatingActionButton: FloatingActionButton(
        heroTag: 'search',
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          showSearch(context: context, delegate: SearchBar());
        },
        child: const Icon(Icons.search),
      ),
      floatingActionButtonLocation: isSmallScreen(context)
          ? FloatingActionButtonLocation.miniCenterDocked
          : null,
    );
  }
}
