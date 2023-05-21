import 'package:med_express/app/results/models/search_data.dart';

class NhsData extends SearchData {
  final String _text;
  Map<String, Object>? _mapCache;

  NhsData.fromJSON(Map<String, dynamic> data)
      : _text = data['text'].toString(),
        super(
          title: data['title'].toString(),
          summary: data['summary']?.toString(),
          keywords: List<String>.from(data['keywords'] ?? []),
        );

  String get text => _text;

  @override
  Map<String, Object> get toMap {
    _mapCache ??= {
      'title': title,
      'summary': summary,
      'text': text,
      'keywords': keywords
    };

    return _mapCache!;
  }
}
