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

final valueMap = [
  // n, trump, leading, a, b, expected
  {'n': 1, 't': HEARTS, 'l': UNKNOWN, 'a': C.$KH, 'b': C.$2H, 'e': 1},
  {'n': 2, 't': CLUBS, 'l': UNKNOWN, 'a': C.$2D, 'b': C.$AD, 'e': 1},
  {'n': 3, 't': CLUBS, 'l': UNKNOWN, 'a': C.$10D, 'b': C.$10H, 'e': 1},
  {'n': 4, 't': CLUBS, 'l': UNKNOWN, 'a': C.$AC, 'b': C.$KS, 'e': 1},
  {'n': 5, 't': CLUBS, 'l': HEARTS, 'a': C.$2C, 'b': C.$KH, 'e': 1},
  {'n': 6, 't': CLUBS, 'l': HEARTS, 'a': C.$2S, 'b': C.$6S, 'e': 1},
  {'n': 7, 't': CLUBS, 'l': HEARTS, 'a': C.$10D, 'b': C.$6S, 'e': 1},
  {'n': 8, 't': CLUBS, 'l': HEARTS, 'a': C.$2H, 'b': C.$10D, 'e': 1},
  {'n': 9, 't': CLUBS, 'l': UNKNOWN, 'a': C.$QD, 'b': C.$10H, 'e': 1},
  {'n': 10, 't': CLUBS, 'l': CLUBS, 'a': C.$QC, 'b': C.$10C, 'e': 1},
  {'n': 11, 't': CLUBS, 'l': CLUBS, 'a': C.$QS, 'b': C.$10S, 'e': 1},
];

void main() {
  group('Ranker mixed suit comparo', () {
    valueMap.forEach((values) {
      test('$values.n', () {
        final trumpSuit = values['t'] as Suit;
        final leadingSuit = values['l'] as Suit;
        final cardA = values['a'] as Card;
        final cardB = values['b'] as Card;
        final ranker = Ranker(trumpSuit, leadingSuit);

        // test
        final result = ranker.customSort(cardA, cardB);

        final expected = values['e'] as int;
        expect(result, expected);
      });
    }); // valueMap
  }); // group
} // main
