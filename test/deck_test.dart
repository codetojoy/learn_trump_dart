import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/models/deck.dart';
import 'package:learn_trump_dart/utils/constants.dart';
import 'package:test/test.dart';

void main() {
  late var deck;
  group('Card', () {
    setUp(() {
      deck = Deck();
    });
    test('constructor basic', () {
      // test
      // no-op

      expect(true, deck.cards.length == Const.NUM_CARDS_IN_DECK);
      expect(true, C.$AC.id == deck.cards[0].id);
      expect(true, C.$KS.id == deck.cards[deck.cards.length - 1].id);
    });
    test('take basic', () {
      final n = 3;
      // test
      var result = deck.take(n);

      expect(result.length, n);
      expect(result[0].id, C.$AC.id);
      expect(result[1].id, C.$2C.id);
      expect(result[2].id, C.$3C.id);
      expect(deck.cards.length, Const.NUM_CARDS_IN_DECK - n);
    });
  }); // group
}
