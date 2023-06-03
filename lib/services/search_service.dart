import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:med_express/app/app.dart';
import 'package:med_express/services/models/broker_response_data.dart';
import 'package:med_express/services/models/nlp_process.dart';
import 'package:med_express/services/user.dart';

abstract class SearchService {
  static const Map<String, String> _jsonHeaders = {
    'Content-Type': 'application/json'
  };
  static const String _brokerURL = '${App.serverIP}:8080/handle';

  static const List<String> _validSites = ['wiki', 'pubmed', 'nhs'];

  static List<String> get validSites => _validSites;

  static Future<BrokerResponseData> requestSearch(String search) async {
    return _postBrokerWithData({
      'action': 'search',
      'search': {
        'keyword': search,
        'sites_to_search': User.current.sitePreferences,
      },
    });
  }

  static Future<String> requestPDF({required String pmcid}) async {
    final response = await _postBrokerWithData({
      'action': 'get-pdf',
      'search': {'keyword': pmcid}
    });

    if (response.error) {
      return response.message;
    }

    return response.data['pdf_text'].toString();
  }

  static Future<String> processTextWithNLP(
    String text,
    NLPProcess process,
  ) async {
    const maxSimplifyTextLen = 25000;
    if (process == NLPProcess.simplify && text.length > maxSimplifyTextLen) {
      return 'Text selected too big for simplification.';
    }

    final response = await _postBrokerWithData({
      'action': 'process-text',
      'nlp': {
        'process': process.name,
        'text': text,
      }
    });

    if (response.error) {
      return response.message;
    }

    return response.data.toString();
  }

  static Future<BrokerResponseData> _postBrokerWithData(
    Map<String, Object> data,
  ) async {
    try {
      final request = http.Request(
        'POST',
        Uri.parse(_brokerURL),
      );

      request.body = json.encode(data);
      request.headers.addAll(_jsonHeaders);

      final response = await request.send();

      final stringData = await response.stream.bytesToString();

      final jsonData = jsonDecode(stringData);

      final brokerData = BrokerResponseData.fromJSON(jsonData);

      return brokerData;
    } catch (e) {
      final data = BrokerResponseData(
        error: true,
        message:
            'Failed to receive response from server with error: ${e.toString()}',
      );

      return data;
    }
  }
}
