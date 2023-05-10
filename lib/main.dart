import 'package:flutter/material.dart';

import 'package:med_express/app/enter/pages/enter_page.dart';
import 'package:med_express/app/enter/pages/welcome_page.dart';
import 'package:med_express/app/home/pages/home_page.dart';
import 'package:med_express/app/home/pages/user_page.dart';
import 'package:med_express/appearance/themes.dart' as themes;

const appName = '⚞MedExpress';
const serverIP = 'http://127.0.0.1'; //'http://192.168.31.22';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.route: (context) => const HomePage(),
        EnterPage.route: (context) => const EnterPage(),
        WelcomePage.route: (context) => const WelcomePage(),
        UserPage.route: (context) => const UserPage(),
      },
      theme: themes.lightTheme,
      darkTheme: themes.darkTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
