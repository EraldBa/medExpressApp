import 'package:med_express/app/results/models/nhs_data.dart';
import 'package:med_express/app/results/models/pubmed_data.dart';
import 'package:med_express/app/results/models/search_data.dart';
import 'package:med_express/app/results/models/wiki_data.dart';

class SearchResults {
  final String _keyword;
  final bool _error;
  final String _message;
  WikiData? _wikiData;
  List<PubMedData>? _pubmedData;
  List<NhsData>? _nhsData;

  bool get error => _error;
  String get keyword => _keyword;
  String get message => _message;
  WikiData? get wikiData => _wikiData;
  List<PubMedData>? get pubmedData => _pubmedData;
  List<NhsData>? get nhsData => _nhsData;

  factory SearchResults.fromJSON({
    required String keyword,
    required Map<String, dynamic> result,
  }) {
    try {
      return SearchResults._from(keyword, result);
    } catch (_) {
      return SearchResults._err(keyword);
    }
  }

  SearchResults._from(String keyword, Map<String, dynamic> result)
      : _keyword = keyword,
        _error = result['error'] as bool,
        _message = result['message'].toString() {
    if (_error) {
      return;
    }

    final data = List<Map<String, dynamic>>.from(result['data']);

    for (final element in data) {
      final udata = List<Map<String, dynamic>>.from(element['data']);

      switch (element['origin'].toString()) {
        case 'wiki':
          _wikiData ??= WikiData.fromJSON(udata.first);
          break;
        case 'pubmed':
          _pubmedData ??= udata.map((e) => PubMedData.fromJSON(e)).toList();
          break;
        case 'nhs':
          _nhsData ??= udata.map((e) => NhsData.fromJSON(e)).toList();
          break;
      }
    }
  }

  SearchResults._err(String keyword)
      : _keyword = keyword,
        _error = true,
        _message = 'data sent from server improperly formated';

  Map<String, List<SearchData>> get dataForCards {
    final data = <String, List<SearchData>>{};

    if (pubmedData != null) {
      data.addAll({'pubmed': pubmedData!});
    }
    if (nhsData != null) {
      data.addAll({'nhs': nhsData!});
    }

    return data;
  }
}
