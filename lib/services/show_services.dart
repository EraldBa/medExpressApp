import 'package:flutter/material.dart';
import 'package:med_express/appearance/const_colors.dart' as const_colors;
import 'package:med_express/services/search_service.dart';
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

Future<NLPProcess> nlpProcessOptionsModalButtomSheet(
  BuildContext context,
) async {
  final process = await showModalBottomSheet<NLPProcess>(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(1.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0),
      ),
    ),
    isScrollControlled: true,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...NLPProcess.values.map((nlpProcess) {
            return MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              onPressed: () => Navigator.of(context).pop(nlpProcess),
              child: Text(
                nlpProcess.name,
                style: const TextStyle(fontSize: 20.0),
              ),
            );
          })
        ],
      );
    },
  );

  return process ?? NLPProcess.none;
}
