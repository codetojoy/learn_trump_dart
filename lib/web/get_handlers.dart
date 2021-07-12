import 'dart:io';

import './rank_handler.dart';
import './utils.dart';

final _rankHandler = RankHandler();

void handleGet(HttpRequest request) {
  final path = request.uri.path;

  print('TRACER path: $path');

  switch (path) {
    case '/rank':
      _rankHandler.handleRank(request);
      break;
    default:
      handleUnknown(request);
      break;
  }
}