import 'dart:io';

void handleUnknown(HttpRequest request) {
  final text = 'error: not found';
  request.response.statusCode = HttpStatus.notFound;
  request.response
    ..write(text)
    ..close();
}

void handleError(HttpRequest request, String message) {
  request.response.statusCode = HttpStatus.badRequest;
  request.response
    ..write(message)
    ..close();
}
