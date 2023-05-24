import 'package:flutter/material.dart';
import 'package:med_express/app/results/components/interactive_card.dart';
import 'package:med_express/app/results/components/wiki_results.dart';
import 'package:med_express/app/results/models/search_result.dart';
import 'package:med_express/services/models/broker_response_data.dart';

class ResultPage extends StatelessWidget {
  final SearchResults results;
  final String keyword;

  ResultPage({
    super.key,
    required this.keyword,
    required BrokerResponseData brokerData,
  }) : results = SearchResults.fromBrokerResults(keyword, brokerData);

  static MaterialPageRoute customRoute(
    BuildContext context,
    String query,
    BrokerResponseData brokerData,
  ) {
    return MaterialPageRoute(
      builder: (context) => ResultPage(keyword: query, brokerData: brokerData),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: results.brokerData.error
          ? Text(
              'Error occured getting results for ${results.keyword}: ${results.brokerData.message}',
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
                ...InteractiveCard.listFromSearchResults(context, results)
                    .map((e) => SliverToBoxAdapter(child: e)),
              ],
            ),
    );
  }
}
