import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_express/app/app.dart';
import 'package:med_express/services/user.dart';

enum SearchErrors { connectionError }

enum NLPProcess { translate, simplify, none }

abstract class SearchService {
  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json'
  };
  static const String _brokerURL = '${App.serverIP}:8080/handle';

  static Future<Map<String, dynamic>> requestSearch(String search) async {
    return _postBrokerWithData({
      'action': 'search',
      'search': {
        'keyword': search,
        'sites_to_search': User.current.sitePreferences,
      },
    });
  }

  static Future<String> processTextWithNLP(
    String text,
    NLPProcess process,
  ) async {
    final response = await _postBrokerWithData({
      'action': 'process-text',
      'nlp': {
        'process': process.name,
        'text': text,
      }
    });

    if (response['error'] == true) {
      return response['message'];
    }

    return response['data'].toString();
  }

  static Future<Map<String, dynamic>> _postBrokerWithData(
    Map<String, Object> data,
  ) async {
    late final http.StreamedResponse response;

    try {
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
