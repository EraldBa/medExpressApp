import 'package:flutter/material.dart';

mixin AdaptiveScreenMixin {
  static const double maxSmallScreenWidth = 900.0;

  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < maxSmallScreenWidth;
  }

  bool isBigScreen(BuildContext context) => !isSmallScreen(context);
}
