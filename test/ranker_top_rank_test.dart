import 'package:collection/collection.dart';
import 'package:test/test.dart';

import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/services/ranker.dart';

const CLUBS = Suit.CLUBS;
const DIAMONDS = Suit.DIAMONDS;
const HEARTS = Suit.HEARTS;
const SPADES = Suit.SPADES;
const UNKNOWN = Suit.UNKNOWN;

// n, trump, leading, cards, expected
var v1 = {
  'n': 1,
  't': HEARTS,
  'l': UNKNOWN,
  'c': [C.$5H, C.$JH, C.$4H],
  'e': [C.$5H],
};
var v2 = {
  'n': 2,
  't': HEARTS,
  'l': DIAMONDS,
  'c': [C.$KC, C.$KS, C.$4C],
  'e': [C.$KC, C.$KS],
};
var v3 = {
  'n': 3,
  't': CLUBS,
  'l': HEARTS,
  'c': [C.$KH, C.$QS, C.$10C],
  'e': [C.$10C],
};

final valueMap = [
  v1,
  v2,
  v3,
];

void main() {
  group('Ranker mixed suit comparo', () {
    valueMap.forEach((values) {
      test('$values.n', () {
        final trumpSuit = values['t'] as Suit;
        final leadingSuit = values['l'] as Suit;
        final cards = values['c'] as List<Card>;
        final ranker = Ranker(trumpSuit, leadingSuit);

        // test
        final result = ranker.getTopRankedCards(cards);

        final expected = values['e'] as List<Card>;
        expect(result.length, expected.length);
        expected.forEach((card) {
          var found = result.contains(card);
          if (!found) {
            print('\nTRACER a: $result e: $expected\n');
          }
          expect(found, true);
        });
      });
    }); // valueMap
  }); // group
} // main
