class BrokerResponseData {
  final bool _error;
  final String _message;
  final dynamic _data;

  BrokerResponseData({
    required bool error,
    required String message,
    dynamic data,
  })  : _error = error,
        _message = message,
        _data = data;

  BrokerResponseData.fromJSON(Map<String, dynamic> data)
      : _error = data['error'] as bool,
        _message = data['message'].toString(),
        _data = data['data'];

  bool get error => _error;
  String get message => _message;
  dynamic get data => _data;
}
