abstract class SearchData {
  static const _nodata = 'No data available';

  final String _title;
  final String? _summary;
  final List<String> _keywords;

  SearchData({
    required String title,
    required List<String> keywords,
    String? summary,
  })  : _title = title,
        _summary = summary,
        _keywords = keywords;

  String get nodata => _nodata;

  String get title => _title;

  String get summary => _summary ?? _nodata;

  List<String> get keywords => _keywords;

  Map<String, Object> get toMap => throw (UnimplementedError);
}
