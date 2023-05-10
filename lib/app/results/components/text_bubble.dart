import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String text, title;
  final Color color;
  final VoidCallback? onTap;

  const TextBubble(
    this.text, {
    super.key,
    required this.title,
    required this.color,
    this.onTap,
  });

  TextBubble.fromList(
    List<String> t, {
    super.key,
    this.onTap,
    required this.title,
    required this.color,
  }) : text = t.join(', ');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        elevation: 20.0,
        margin: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: SelectableText.rich(
            onTap: onTap,
            TextSpan(
              children: [
                TextSpan(
                  text: '$title\n',
                  style: const TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: text,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
