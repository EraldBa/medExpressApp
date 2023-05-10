import 'package:flutter/material.dart';

import 'package:med_express/app/app.dart';
import 'package:med_express/app/enter/pages/login_page.dart';
import 'package:med_express/app/enter/pages/sign_up_page.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';

class EnterPage extends StatefulWidget {
  const EnterPage({super.key});

  static String get route => '/enter-page';

  @override
  State<EnterPage> createState() => _EnterPageState();
}

class _EnterPageState extends State<EnterPage> with AdaptiveScreenMixin {
  static const List<Tab> _tabs = [
    Tab(
      child: Text('LOGIN'),
    ),
    Tab(
      child: Text('SIGNUP'),
    )
  ];

  static const List<Widget> _pages = [
    LoginPage(),
    SignUpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            App.name,
            textAlign: TextAlign.center,
          ),
          bottom: TabBar(
            isScrollable: isBigScreen(context),
            tabs: _tabs,
          ),
        ),
        body: Row(
          children: [
            if (isBigScreen(context))
              Expanded(
                flex: 3,
                child: Image.asset('assets/images/doctor-computer.png'),
              ),
            const Expanded(
              flex: 2,
              child: TabBarView(
                children: _pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
