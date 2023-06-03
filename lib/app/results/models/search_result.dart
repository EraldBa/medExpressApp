import 'package:med_express/app/results/models/nhs_data.dart';
import 'package:med_express/app/results/models/pubmed_data.dart';
import 'package:med_express/app/results/models/search_data.dart';
import 'package:med_express/app/results/models/wiki_data.dart';
import 'package:med_express/services/models/broker_response_data.dart';

class SearchResults {
  final String _keyword;
  final BrokerResponseData _brokerData;
  WikiData? _wikiData;
  List<PubMedData>? _pubmedData;
  List<NhsData>? _nhsData;

  String get keyword => _keyword;
  BrokerResponseData get brokerData => _brokerData;
  WikiData? get wikiData => _wikiData;
  List<PubMedData>? get pubmedData => _pubmedData;
  List<NhsData>? get nhsData => _nhsData;

  factory SearchResults.fromJSON({
    required String keyword,
    required Map<String, dynamic> result,
  }) {
    try {
      return SearchResults._fromJSON(keyword, result);
    } catch (_) {
      return SearchResults._err(keyword);
    }
  }

  factory SearchResults.fromBrokerResults(
      String keyword, BrokerResponseData brokerData) {
    try {
      return SearchResults._fromBrokerResults(keyword, brokerData);
    } catch (_) {
      return SearchResults._err(keyword);
    }
  }

  SearchResults._fromBrokerResults(
    String keyword,
    this._brokerData,
  ) : _keyword = keyword {
    _init();
  }

  SearchResults._fromJSON(String keyword, Map<String, dynamic> result)
      : _keyword = keyword,
        _brokerData = BrokerResponseData.fromJSON(result) {
    _init();
  }

  void _init() {
    if (brokerData.error) {
      return;
    }

    final body = List<Map<String, dynamic>>.from(brokerData.data);

    for (final element in body) {
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
        _brokerData = BrokerResponseData(
          error: true,
          message: 'Data improperly formatted froom server',
        );

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
