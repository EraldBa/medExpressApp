import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';

class SimpleDataPage extends StatelessWidget {
  final String title;
  final String text;

  const SimpleDataPage({
    super.key,
    required this.title,
    required this.text,
  });

  static MaterialPageRoute customRoute(String title, String text) {
    return MaterialPageRoute(
      builder: (context) => SimpleDataPage(title: title, text: text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title.toUpperCase())),
      body: Center(
        child: SingleChildScrollView(
          child: TextBubble(
            text,
            title: title,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
