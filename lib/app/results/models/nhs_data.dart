import 'package:med_express/app/results/models/search_data_interface.dart';

class NhsData implements SearchDataInterface {
  final String _title, _text;
  final String? _summary;
  Map<String, Object>? _mapCache;

  NhsData.fromJSON(Map<String, dynamic> data)
      : _title = data['title'].toString(),
        _text = data['text'].toString(),
        _summary = data['summary']?.toString();

  @override
  String get title => _title;
  @override
  String get summary => _summary ?? 'No data available';

  String get text => _text;

  @override
  Map<String, Object> get toMap {
    _mapCache ??= {
      'title': title,
      'summary': summary,
      'text': text,
    };

    return _mapCache!;
  }
}
