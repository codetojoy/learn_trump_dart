import 'dart:io';

import '../models/config.dart';
import '../models/deck.dart';
import '../models/table.dart';
import '../services/dealer.dart';
import '../services/dealer.dart';
import '../utils/constants.dart';

class Game {
  final _dealer = Dealer();

  Table setUp() {
    var deck = Deck();
    deck.shuffle();
    var table = Config.instance.getTable(deck);
    table.audit();
    _dealer.dealHands(table, deck);
    table.audit();
    final topCard = deck.take(1)[0];
    table.topCard = topCard;
    table.audit();
    return table;
  }

  void play() {
    final table = setUp();
    print('setup\n $table');
    var roundCount = 1;
    final numRounds = Const.NUM_CARDS_IN_HAND;
    while (roundCount <= numRounds) {
      _dealer.playRound(table);
      table.audit();
      print('round $roundCount\n$table');
      roundCount++;
    }
    print('end\n $table');
    table.audit();
  }
}
