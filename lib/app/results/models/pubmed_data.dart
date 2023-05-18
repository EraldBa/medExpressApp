import 'package:med_express/app/results/models/search_data_interface.dart';

class PubMedData implements SearchDataInterface {
  static const String _nodata = 'No data available';
  final String _pmid, _pmcid, _title;
  final String? _link, _summary, _abstract, _keywords;
  final List<String> _authors;
  Map<String, Object>? _mapCache;

  PubMedData.fromJSON(Map<String, dynamic> data)
      : _pmid = data['pmid'].toString(),
        _pmcid = data['pmcid'].toString(),
        _title = data['title'].toString(),
        _link = data['link']?.toString(),
        _summary = data['summary']?.toString(),
        _abstract = data['abstract']?.toString(),
        _keywords = data['keywords']?.toString(),
        _authors = List<String>.from(data['authors'] ?? <String>[_nodata]);

  @override
  String get title => _title;
  @override
  String get summary => _summary ?? _nodata;

  String get pmid => _pmid;
  String get pmcid => _pmcid;
  String get link => _link ?? _nodata;
  String get abstract => _abstract ?? _nodata;
  String get keywords => _keywords ?? _nodata;
  List<String> get authors => _authors;

  @override
  Map<String, Object> get toMap {
    _mapCache ??= {
      'title': title,
      'authors': authors,
      'link': link,
      'pmid': pmid,
      'pmcid': pmcid,
      'summary': summary,
      'abstract': abstract,
      'keywords': keywords,
    };

    return _mapCache!;
  }
}
