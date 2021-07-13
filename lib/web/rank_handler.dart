import 'dart:io';

import './keys.dart';
import './utils.dart';
import './services/adapter.dart';
import '../utils/logger.dart';

class RankHandler {
  final _adapter = Adapter();

  bool _validateQuery(Map<String, String> params) {
    var result = params.containsKey(Keys.CARDS) &&
        params.containsKey(Keys.LEADING) &&
        params.containsKey(Keys.TRUMP);
    return result;
  }

  void handleRank(HttpRequest request) {
    final uri = request.uri;
    final queryParams = uri.queryParameters;

    if (!_validateQuery(queryParams)) {
      handleError(request, 'bad request');
      return;
    }
    final trump = queryParams[Keys.TRUMP]!;
    final leading = queryParams[Keys.LEADING]!;
    final cards = queryParams[Keys.CARDS]!;
    L.log('rank t: $trump l: $leading cards: $cards');
    var jsonString = '';
    try {
      jsonString = _adapter.rank(trump, leading, cards);
    } catch (ex) {
      handleError(request, ex.toString());
      return;
    }

    request.response.headers
        .set(HttpHeaders.contentTypeHeader, 'application/json');
    request.response
      ..write(jsonString)
      ..close();
  }
}
