class NhsData {
  final String _title, _text;
  final String? _summary;

  NhsData.fromJSON(Map<String, dynamic> data)
      : _title = data['title'].toString(),
        _text = data['text'].toString(),
        _summary = data['summary']?.toString();

  String get title => _title;
  String get text => _text;
  String get summary => _summary ?? 'No data available';
}
