import 'dart:io';

import '../services/game.dart';

class GameLoop {
  void loop() {
    var done = false;

    while (!done) {
      stdout.writeln('N - new game');
      stdout.writeln('Q - quit');
      stdout.writeln('your choice: ');
      final input = stdin.readLineSync();
      stdout.writeln('You typed: $input');
      final upperInput = input!.toUpperCase();
      if (upperInput == 'N') {
        Game().play();
      } else if (upperInput == 'Q') {
        done = true;
      }
    }
    stdout.writeln('bye...');
  }
}
