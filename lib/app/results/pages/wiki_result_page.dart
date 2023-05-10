import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/text_bubble.dart';
import 'package:med_express/app/results/models/wiki_data.dart';

class WikiResultPage extends StatelessWidget {
  final WikiData? wikiData;
  const WikiResultPage(this.wikiData, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wikipedia Summary'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/wikipedia-logo.png',
                height: 300.0,
              ),
              TextBubble(
                wikiData?.extract ?? 'No data available',
                title: wikiData?.title ?? 'No data available',
                color: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
