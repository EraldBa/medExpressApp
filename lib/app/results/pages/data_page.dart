import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';
import 'package:med_express/app/results/models/search_data_interface.dart';
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

  final SearchDataInterface data;

  const DataPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final columnBody = <Widget>[];

    int i = 0;
    data.toMap.forEach((name, value) {
      final color = _randomColors[i++];
      if (value is List<String>) {
        columnBody.add(TextBubble.fromListOfStrings(
          value,
          title: name,
          color: color,
        ));
      } else if (value is String) {
        columnBody.add(TextBubble(
          value.formatWith('\n', step: isSmallScreen(context) ? 50 : 70),
          title: name,
          color: color,
        ));
      }
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
