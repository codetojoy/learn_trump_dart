import 'dart:io';
import 'dart:convert';

void handleUnknown(HttpRequest request) {
  final text = 'error: not found';
  request.response.statusCode = HttpStatus.notFound;
  request.response
    ..write(text)
    ..close();
}

void handlePing(HttpRequest request) {
  final jsonStr = myJsonEncode('', '');
  request.response.headers
      .set(HttpHeaders.contentTypeHeader, 'application/json');
  request.response
    ..write(jsonStr)
    ..close();
}

void handleError(HttpRequest request, String message) {
  request.response.statusCode = HttpStatus.badRequest;
  request.response
    ..write(message)
    ..close();
}

String myJsonEncode(String key, String value) {
  final timestamp = DateTime.now();
  final text = 'OK $timestamp';
  final map = {
    if (key.isNotEmpty) key: value,
    'message': text,
  };
  final jsonStr = jsonEncode(map);
  return jsonStr;
}
