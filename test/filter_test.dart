import 'package:collection/collection.dart';
import 'package:test/test.dart';

import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/models/trick.dart';
import 'package:learn_trump_dart/services/filter.dart';

const CLUBS = Suit.CLUBS;
const DIAMONDS = Suit.DIAMONDS;
const HEARTS = Suit.HEARTS;
const SPADES = Suit.SPADES;
const UNKNOWN = Suit.UNKNOWN;
const tsUNKNOWN = TrickState.UNKNOWN;
const tsLEADING_NO_TRUMP = TrickState.LEADING_NO_TRUMP;
const tsTRUMP_PLAYED = TrickState.TRUMP_PLAYED;

final c1 = [C.$AC, C.$2D, C.$3H, C.$4S];
final e1 = c1;
final c2 = [C.$AC, C.$2D, C.$3H, C.$4S];
final e2 = [C.$AC, C.$3H];
final c3 = [C.$AC, C.$2C, C.$2D, C.$3H, C.$4S];
final e3 = [C.$AC, C.$2C];
final c4 = [C.$2D, C.$3H, C.$4S];
final e4 = c4;

final valueMap = [
  // n, cards, trumpSuit, leadingSuit, trumpPlayed, expected
  {'n': 1, 'c': c1, 't': CLUBS, 'l': UNKNOWN, 'tp': false, 'e': e1},
  {'n': 2, 'c': c2, 't': CLUBS, 'l': HEARTS, 'tp': false, 'e': e2},
  {'n': 3, 'c': c3, 't': CLUBS, 'l': CLUBS, 'tp': true, 'e': e3},
  {'n': 4, 'c': c4, 't': CLUBS, 'l': CLUBS, 'tp': true, 'e': e4},
];

void main() {
  group('ProperFilter getCandidates', () {
    final listEquals = const ListEquality().equals;
    final filter = Filters().buildFilter(FilterType.proper);
    valueMap.forEach((values) {
      test('$values.n', () {
        final cards = values['c'] as List<Card>;
        final trumpSuit = values['t'] as Suit;
        final leadingSuit = values['l'] as Suit;
        final trumpPlayed = values['tp'] as bool;

        // test
        final result =
            filter.getCandidates(cards, trumpSuit, leadingSuit, trumpPlayed);

        final expected = values['e'] as List<Card>;
        expect(listEquals(result, expected), true);
      });
    }); // valueMap
  }); // group
} // main
