import 'dart:io';

import 'package:learn_trump_dart/web/get_handlers.dart';
import 'package:learn_trump_dart/web/utils.dart';

Future<void> main(List<String> args) async {
  final port = 5151;
  final server = await createServer(port);
  print('Server started: ${server.address} port ${server.port}');
  await handleRequests(server);
}

Future<void> handleRequests(HttpServer server) async {
  await for (HttpRequest request in server) {
    switch (request.method) {
      case 'GET':
        handleGet(request);
        break;
      default:
        handleUnknown(request);
    }
  }
}

Future<HttpServer> createServer(int port) async {
  final address = InternetAddress.loopbackIPv4;
  return await HttpServer.bind(address, port);
}

Future<void> usage() async {
  print('Usage: example_server.dart [game|server]');
  exit(-5150);
}
