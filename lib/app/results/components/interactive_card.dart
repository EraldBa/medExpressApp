import 'package:flutter/material.dart';
import 'package:med_express/app/results/models/search_result.dart';
import 'package:med_express/app/results/pages/search_results_page.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';

class InteractiveCard extends StatelessWidget with AdaptiveScreenMixin {
  final VoidCallback onTap;
  final String title;
  final String image;

  const InteractiveCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.image,
  });

  static List<InteractiveCard> listFromSearchResults(
    BuildContext context,
    SearchResults results,
  ) {
    const randomImages = [
      'assets/images/doctor.png',
      'assets/images/drugstore.png'
    ];

    final cards = <InteractiveCard>[];

    int i = 0;

    results.dataForCards.forEach((title, data) {
      final image = randomImages[i++];
      cards.add(
        InteractiveCard(
          title: title.toUpperCase(),
          onTap: () {
            Navigator.push(
              context,
              SearchResultsPage.customRouter(
                context,
                data: data,
                image: image,
              ),
            );
          },
          image: image,
        ),
      );
    });

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: isSmallScreen(context) ? 20.0 : 200.0,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 500.0,
            color: Colors.purple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: image,
                  child: Image.asset(
                    image,
                    height: 400.0,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
