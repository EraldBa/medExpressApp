import 'package:flutter/material.dart';
import 'package:med_express/app/results/models/search_result.dart';
import 'package:med_express/app/results/pages/nhs_results_page.dart';
import 'package:med_express/app/results/pages/pubmed_results_page.dart';
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
    const pubmedImage = 'assets/images/doctor.png';
    const nhsImage = 'assets/images/drugstore.png';

    final cards = <InteractiveCard>[
      if (results.pubmedData != null)
        InteractiveCard(
          title: 'PubMed',
          onTap: () {
            Navigator.push(
              context,
              PubMedResultsPage.customRouter(
                context,
                data: results.pubmedData!,
                image: pubmedImage,
              ),
            );
          },
          image: pubmedImage,
        ),
      if (results.nhsData != null)
        InteractiveCard(
          title: 'NHS',
          onTap: () {
            Navigator.push(
              context,
              NhsResultPage.customRouter(
                context,
                data: results.nhsData!,
                image: nhsImage,
              ),
            );
          },
          image: nhsImage,
        )
    ];

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
