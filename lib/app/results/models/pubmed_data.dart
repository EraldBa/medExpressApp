class PubMedData {
  static const String _nodata = 'No data available';
  final String _pmid, _pmcid, _title;
  final String? _link, _summary, _abstract, _keywords;
  final List<String> _authors;

  PubMedData.fromJSON(Map<String, dynamic> data)
      : _pmid = data['pmid'].toString(),
        _pmcid = data['pmcid'].toString(),
        _title = data['title'].toString(),
        _link = data['link']?.toString(),
        _summary = data['summary']?.toString(),
        _abstract = data['abstract']?.toString(),
        _keywords = data['keywords']?.toString(),
        _authors = List<String>.from(data['authors'] ?? <String>[_nodata]);

  String get pmid => _pmid;
  String get pmcid => _pmcid;
  String get title => _title;
  String get link => _link ?? _nodata;
  String get summary => _summary ?? _nodata;
  String get abstract => _abstract ?? _nodata;
  String get keywords => _keywords ?? _nodata;
  List<String> get authors => _authors;
}
