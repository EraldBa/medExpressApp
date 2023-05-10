import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/interactive_card.dart';
import 'package:med_express/app/results/components/wiki_results.dart';
import 'package:med_express/app/results/models/search_result.dart';
import 'package:med_express/app/results/pages/pubmed_results_page.dart';

class ResultPage extends StatelessWidget {
  final SearchResults results;
  final String keyword;

  ResultPage({
    super.key,
    required this.keyword,
    required Map<String, dynamic> data,
  }) : results = SearchResults.fromJSON(keyword: keyword, result: data);

  static MaterialPageRoute customRoute(
    BuildContext context,
    String query,
    Map<String, dynamic> data,
  ) {
    return MaterialPageRoute(
      builder: (context) => ResultPage(keyword: query, data: data),
    );
  }

  List<InteractiveCard> getCards(BuildContext context) {
    final cards = <InteractiveCard>[];

    cards.addAll(
      [
        if (results.pubmedData != null)
          InteractiveCard(
            title: 'PubMed',
            onTap: () {
              Navigator.push(
                context,
                PubMedResultsPage.customRouter(
                  context,
                  results.pubmedData!,
                  'assets/images/doctor.png',
                ),
              );
            },
            image: 'assets/images/doctor.png',
          ),
        if (results.pubmedData != null)
          InteractiveCard(
            title: 'PubMed',
            onTap: () {
              Navigator.push(
                context,
                PubMedResultsPage.customRouter(
                  context,
                  results.pubmedData!,
                  'assets/images/drugstore.png',
                ),
              );
            },
            image: 'assets/images/drugstore.png',
          ),
      ],
    );

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: results.error
          ? Text(
              'Error occured getting results for ${results.keyword}: ${results.message}',
            )
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250.0,
                  pinned: true,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Results for: ${results.keyword}',
                    ),
                    background: WikiResults(wikiData: results.wikiData),
                  ),
                ),
                ...getCards(context).map((e) => SliverToBoxAdapter(child: e)),
              ],
            ),
    );
  }
}
