import 'package:flutter/material.dart';

import 'package:med_express/mixins/adaptive_mixin.dart';

class AccountPageButton extends StatelessWidget with AdaptiveScreenMixin {
  static const smallScreenBtnSize = EdgeInsets.symmetric(
    horizontal: 50.0,
    vertical: 15.0,
  );

  static const bigScreenBtnSize = EdgeInsets.symmetric(
    horizontal: 70.0,
    vertical: 20.0,
  );

  final String text;
  final VoidCallback onPressed;

  const AccountPageButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: isSmallScreen(context) ? smallScreenBtnSize : bigScreenBtnSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      onPressed: onPressed,
      color: Colors.blue,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15.0,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
