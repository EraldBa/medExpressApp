import 'package:flutter/material.dart';
import 'package:med_express/app/results/models/wiki_data.dart';

class WikiResultBar extends StatelessWidget {
  const WikiResultBar(this.wikiData, {super.key});

  final WikiData? wikiData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(50.0),
        color: const Color.fromARGB(255, 45, 4, 114),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Wikipedia Summary for: ${wikiData?.title}\n\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: wikiData?.extract
                              .split('.')
                              .sublist(0, 3)
                              .join('.') ??
                          'No data available',
                    ),
                    const TextSpan(
                      text: '\t\tView full summary...\n',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
