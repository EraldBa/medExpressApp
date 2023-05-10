import 'package:flutter/material.dart';

import 'package:med_express/appearance/const_colors.dart';

const appBarTheme = AppBarTheme(
  backgroundColor: Color.fromARGB(234, 0, 65, 177),
  foregroundColor: Colors.white,
);

const navDrawerTheme = NavigationDrawerThemeData(indicatorColor: Colors.blue);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: primaryColor,
  primaryColorLight: Colors.white,
  primaryColorDark: primaryColorDark,
  splashColor: Colors.blue,
  scaffoldBackgroundColor: scaffoldLight,
  appBarTheme: appBarTheme,
  navigationDrawerTheme: navDrawerTheme,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: primaryColorDark,
  primaryColorLight: primaryColorDark,
  primaryColorDark: Colors.white,
  splashColor: Colors.blue,
  scaffoldBackgroundColor: scaffoldDark,
  appBarTheme: appBarTheme,
  navigationDrawerTheme: navDrawerTheme,
);

InputDecoration standardInputDec(
  BuildContext context, {
  required IconData icon,
  required String? hintText,
}) {
  return InputDecoration(
    border: const OutlineInputBorder(),
    contentPadding: const EdgeInsets.only(left: 30.0),
    fillColor: Theme.of(context).primaryColor,
    filled: true,
    prefixIcon: Icon(icon),
    hintText: hintText,
  );
}
