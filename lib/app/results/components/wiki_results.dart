import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:med_express/app/results/models/wiki_data.dart';
import 'package:med_express/app/results/pages/wiki_result_page.dart';
import 'package:med_express/app/results/widgets/wiki_result_bar.dart';

class WikiResults extends StatelessWidget {
  const WikiResults({
    super.key,
    this.wikiData,
  });

  final WikiData? wikiData;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: const Color.fromARGB(255, 45, 4, 114),
      closedBuilder: (context, action) {
        return WikiResultBar(wikiData);
      },
      openBuilder: (context, action) {
        return WikiResultPage(wikiData);
      },
    );
  }
}
