import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';
import 'package:med_express/app/results/models/pubmed_data.dart';
import 'package:med_express/extensions/string_extension.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';

class PubMedPage extends StatelessWidget with AdaptiveScreenMixin {
  final PubMedData data;

  const PubMedPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextBubble(
                data.title,
                title: 'Title',
                color: Colors.red,
              ),
              TextBubble.fromList(
                data.authors,
                title: 'Authors',
                color: Colors.deepPurple,
              ),
              TextBubble(
                data.link,
                title: 'Link',
                color: Colors.blue,
              ),
              TextBubble(
                data.abstract.formatWith(
                  '\n',
                  step: isSmallScreen(context) ? 40 : 60,
                ),
                title: 'Abstract',
                color: Colors.lightGreen,
              ),
              TextBubble(
                data.summary.formatWith(
                  '\n',
                  step: isSmallScreen(context) ? 30 : 60,
                ),
                title: 'Summary',
                color: Colors.purple,
              ),
              TextBubble(
                data.keywords,
                title: 'Keywords',
                color: Colors.blueGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
