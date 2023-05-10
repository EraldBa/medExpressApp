import 'package:flutter/material.dart';

import 'package:med_express/appearance/const_colors.dart' as const_colors;
import 'package:med_express/widgets/my_alert_dialog.dart';

void _showSnackBar(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(message),
      duration: const Duration(milliseconds: 1500),
    ),
  );
}

void successSnackBar(BuildContext context, {required String message}) {
  _showSnackBar(context, message, const_colors.successColor);
}

void errorSnackBar(BuildContext context, {required String message}) {
  _showSnackBar(context, message, const_colors.errorColor);
}

void warningSnackBar(BuildContext context, {required String message}) {
  _showSnackBar(context, message, const_colors.warningColor);
}

Future<bool> warningPopUp(
  BuildContext context, {
  required String message,
}) async {
  final accepted = await showDialog<bool>(
    context: context,
    builder: (context) {
      return MyAlertDialog(
        image: 'assets/lottie/question-mark.json',
        message: message,
        textColor: const_colors.warningColor,
        backgroundColor: Theme.of(context).primaryColor,
      );
    },
  );

  return accepted == true;
}
