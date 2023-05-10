import 'package:flutter/material.dart';

import 'package:med_express/app/enter/pages/enter_page.dart';
import 'package:med_express/app/home/pages/user_page.dart';
import 'package:med_express/services/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String get route => '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return User.current.isLoggedIn ? const UserPage() : const EnterPage();
  }
}
