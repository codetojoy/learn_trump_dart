import 'package:test/test.dart';
import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/models/hand.dart';
import 'package:learn_trump_dart/utils/constants.dart';

void main() {
  group('Hand', () {
    setUp(() {});
    test('remove', () {
      var card1 = C.$5H;
      var card2 = C.$2S;
      var card3 = C.$9D;
      var cards = <Card>[card1, card2, card3];

      var hand = Hand.provide(cards);

      // test
      var result = hand.removeCard(card2);

      expect(2, result.cards.length);
    });
  });
}
