import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:med_express/app/app.dart';
import 'package:med_express/app/home/components/search_bar.dart';
import 'package:med_express/appearance/themes.dart';
import 'package:med_express/mixins/adaptive_mixin.dart';

class SearchPage extends StatelessWidget with AdaptiveScreenMixin {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: standardInputDec(
                context,
                hintText: 'Start Searching!',
                icon: Icons.search,
              ),
              textAlign: TextAlign.justify,
              onTap: () {
                showSearch(context: context, delegate: SearchBar());
              },
              onChanged: (text) {
                showSearch(
                  context: context,
                  delegate: SearchBar(),
                  query: text,
                );
              },
            ),
          ),
          const SizedBox(height: 50.0),
          const Text(
            App.name,
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 50.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            constraints: const BoxConstraints(
              maxHeight: 600.0,
            ),
            child: Lottie.asset('assets/lottie/search-doctor.json'),
          ),
        ],
      ),
    );
  }
}
