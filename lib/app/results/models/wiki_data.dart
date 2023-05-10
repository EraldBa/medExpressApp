class WikiData {
  final String _title;
  final String _extract;

  WikiData.fromJSON(Map<String, dynamic> data)
      : _title = data['title'].toString(),
        _extract = data['extract'].toString();

  String get title => _title;
  String get extract => _extract;
}
