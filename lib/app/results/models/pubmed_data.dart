import 'package:med_express/app/results/models/search_data.dart';

class PubMedData extends SearchData {
  final String _pmid;
  final String? _pmcid, _link, _abstract;
  final List<String> _authors;
  Map<String, Object>? _mapCache;

  PubMedData.fromJSON(Map<String, dynamic> data)
      : _pmid = data['pmid'].toString(),
        _pmcid = data['pmcid']?.toString(),
        _link = data['link']?.toString(),
        _abstract = data['abstract']?.toString(),
        _authors = List<String>.from(data['authors'] ?? []),
        super(
          title: data['title'].toString(),
          summary: data['summary']?.toString(),
          keywords: List<String>.from(data['keywords'] ?? []),
        );

  String get pmid => _pmid;
  String get pmcid => _pmcid ?? '';
  String get link => _link ?? nodata;
  String get abstract => _abstract ?? nodata;

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
