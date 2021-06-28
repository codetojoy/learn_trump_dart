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

final c1 = [C.$AC, C.$2D, C.$3H, C.$4S];
final e1 = c1;
final c2 = [C.$AC, C.$2D, C.$3H, C.$4S];
final e2 = [C.$AC, C.$3H];
final c3 = [C.$AC, C.$2C, C.$2D, C.$3H, C.$4S];
final e3 = [C.$AC, C.$2C];
final c4 = [C.$2D, C.$3H, C.$4S];
final e4 = c4;

// n, trump, leading, cards, expected
final v1 = {
  'n': 1,
  't': HEARTS,
  'l': UNKNOWN,
  'c': [C.$5H, C.$JH, C.$4H],
  'e': 1
};
final v2 = {
  'n': 1,
  't': HEARTS,
  'l': DIAMONDS,
  'c': [C.$KC, C.$KS, C.$4C],
  'e': 2
};

final valueMap = [v1, v2];

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

        final expected = values['e'] as int;
        expect(result.length, expected);
      });
    }); // valueMap
  }); // group
} // main
