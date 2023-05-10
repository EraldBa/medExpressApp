import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class MyAlertDialog extends StatelessWidget {
  final String message;
  final String image;
  final Color backgroundColor;
  final Color textColor;

  const MyAlertDialog({
    super.key,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    required this.image,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: SizedBox(
        height: 80.0,
        width: 80.0,
        child: Lottie.asset(
          image,
          repeat: false,
        ),
      ),
      iconColor: textColor,
      iconPadding: const EdgeInsets.all(30.0),
      backgroundColor: Theme.of(context).primaryColor,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 30.0),
      title: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      actions: [
        MaterialButton(
          color: Colors.blue,
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Yes'),
        ),
        MaterialButton(
          color: Colors.red,
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
