import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';
import 'package:med_express/app/results/models/search_data.dart';
import 'package:med_express/extensions/string_extension.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';

class DataPage extends StatelessWidget with AdaptiveScreenMixin {
  static const List<Color> _randomColors = [
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.lightBlue,
    Colors.green,
    Colors.deepPurple
  ];

  static const String _paragraphTerminator = '|';

  final SearchData data;

  const DataPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columnBody = <Widget>[];

    int i = 0;
    data.toMap.forEach((name, value) {
      final color = _randomColors[i++];

      late final Widget textBubble;

      if (value is List<String>) {
        textBubble = TextBubble.fromListOfStrings(
          value,
          title: name,
          color: color,
        );
      } else if (value is String) {
        value = value
            .formatWith('\n', step: isSmallScreen(context) ? 50 : 80)
            .replaceAll(_paragraphTerminator, '\n\n');

        textBubble = TextBubble(
          value,
          title: name,
          color: color,
        );
      } else {
        return;
      }

      columnBody.add(textBubble);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columnBody,
          ),
        ),
      ),
    );
  }
}
