import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_express/app/app.dart';
import 'package:med_express/services/user.dart';

enum SearchErrors { connectionError }

abstract class SearchService {
  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json'
  };
  static const String _brokerURL = '${App.serverIP}:8080/handle';

  static Future<Map<String, dynamic>> requestSearch(String search) async {
    late final http.StreamedResponse response;

    try {
      final data = {
        'action': 'search',
        'search': {
          'keyword': search,
          'sites_to_search': User.current.sitePreferences,
        },
      };

      final request = http.Request(
        'POST',
        Uri.parse(_brokerURL),
      );

      request.body = json.encode(data);
      request.headers.addAll(_jsonHeaders);

      response = await request.send();
    } catch (_) {
      return {'error': SearchErrors.connectionError};
    }

    final stringData = await response.stream.bytesToString();
    return jsonDecode(stringData);
  }
}
