import '../models/table.dart';
import '../models/card.dart';
import '../models/player.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class Auditor {
  static const expected =
      (Const.NUM_CARDS_IN_DECK * (Const.NUM_CARDS_IN_DECK + 1)) / 2;

  int _value(Card card) {
    return (card.isUnknown) ? 0 : card.id + 1;
  }

  int _sumCards(List<Card> cards) {
    var result = 0;
    cards.forEach((card) => result += _value(card));
    return result;
  }

  int _sumPlayers(List<Player> players) {
    var result = 0;
    players.forEach((player) => result += _sumCards(player.cards));
    return result;
  }

  bool audit(Table table) {
    var actual = 0;
    actual += _sumCards(table.deck.cards);
    actual += _sumPlayers(table.players);
    actual += _sumCards(table.discardedCards);
    actual += _value(table.topCard);

    final result = (expected == actual);
    if (!result) {
      L.log('AUDIT ERROR e: $expected a: $actual');
    } else {
      L.log('audit ok');
    }
    return result;
  }
}
