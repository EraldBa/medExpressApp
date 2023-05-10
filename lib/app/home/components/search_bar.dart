import 'package:flutter/material.dart';

import 'package:med_express/app/home/widgets/loading_screen.dart';
import 'package:med_express/app/results/pages/result_page.dart';
import 'package:med_express/services/search_service.dart';
import 'package:med_express/services/show_services.dart' as show;
import 'package:med_express/services/user.dart';

class SearchBar extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () => showResults(context),
        icon: const Hero(tag: 'search', child: Icon(Icons.search)),
      ),
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return buildSuggestions(context);
    }

    if (!User.current.searchHistory.contains(query)) {
      User.current.updateUser(keyword: query);
    }

    // Performing the search
    SearchService.requestSearch(
      query.toLowerCase(),
    ).then(
      (data) {
        switch (data['error']) {
          case SearchErrors.connectionError:
            show.warningSnackBar(
              context,
              message:
                  'Could not get search results for keyword due to connection problems, try again later.',
            );
            showSuggestions(context);
            break;

          case true:
            final message = data['message'];
            show.errorSnackBar(
              context,
              message: 'Server error occured fetching results: $message',
            );
            showSuggestions(context);
            break;

          default:
            Navigator.pushReplacement(
              context,
              ResultPage.customRoute(context, query, data),
            );
            break;
        }
      },
    );

    return const LoadingScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final matchQuery = User.current.searchHistory
        .where((word) => word.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            query = matchQuery[index];
          },
          title: Text(matchQuery[index]),
          trailing: const Icon(Icons.history),
        );
      },
    );
  }
}
