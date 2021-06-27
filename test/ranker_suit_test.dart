import 'package:test/test.dart';

import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/services/ranker.dart';

void main() {
  group('Ranker', () {
    List<Card> _buildCards(Suit suit, bool isTrump) {
      final cards = C.getBySuit(suit);
      if (isTrump && suit != Suit.HEARTS) {
        cards.add(C.$AH);
      }
      return cards;
    }

    void assertRedTrump(List<Card> cards, Suit suit) {
      var i = 0;
      expect(cards[i++].ordinal, Ordinal.TWO);
      expect(cards[i++].ordinal, Ordinal.THREE);
      expect(cards[i++].ordinal, Ordinal.FOUR);
      expect(cards[i++].ordinal, Ordinal.SIX);
      expect(cards[i++].ordinal, Ordinal.SEVEN);
      expect(cards[i++].ordinal, Ordinal.EIGHT);
      expect(cards[i++].ordinal, Ordinal.NINE);
      expect(cards[i++].ordinal, Ordinal.TEN);
      expect(cards[i++].ordinal, Ordinal.QUEEN);
      expect(cards[i++].ordinal, Ordinal.KING);

      if (suit != Suit.HEARTS) {
        expect(cards[i].ordinal, Ordinal.ACE);
        expect(cards[i++].suit, suit);
      }

      expect(cards[i].ordinal, Ordinal.ACE);
      expect(cards[i++].suit, Suit.HEARTS);

      expect(cards[i++].ordinal, Ordinal.JACK);
      expect(cards[i++].ordinal, Ordinal.FIVE);
    }

    void assertBlackTrump(List<Card> cards, Suit suit) {
      var i = 0;
      expect(cards[i++].ordinal, Ordinal.TEN);
      expect(cards[i++].ordinal, Ordinal.NINE);
      expect(cards[i++].ordinal, Ordinal.EIGHT);
      expect(cards[i++].ordinal, Ordinal.SEVEN);
      expect(cards[i++].ordinal, Ordinal.SIX);
      expect(cards[i++].ordinal, Ordinal.FOUR);
      expect(cards[i++].ordinal, Ordinal.THREE);
      expect(cards[i++].ordinal, Ordinal.TWO);
      expect(cards[i++].ordinal, Ordinal.QUEEN);
      expect(cards[i++].ordinal, Ordinal.KING);

      expect(cards[i].ordinal, Ordinal.ACE);
      expect(cards[i++].suit, suit);

      expect(cards[i].ordinal, Ordinal.ACE);
      expect(cards[i++].suit, Suit.HEARTS);

      expect(cards[i++].ordinal, Ordinal.JACK);
      expect(cards[i++].ordinal, Ordinal.FIVE);
    }

    test('customSort diamonds', () {
      const trump = Suit.DIAMONDS;
      final cards = _buildCards(trump, true);
      cards.shuffle();

      // test
      Ranker(trump, Suit.UNKNOWN).customSortArray(cards);

      assertRedTrump(cards, trump);
    });
    test('customSort hearts', () {
      const trump = Suit.HEARTS;
      final cards = _buildCards(trump, true);
      cards.shuffle();

      // test
      Ranker(trump, Suit.UNKNOWN).customSortArray(cards);

      assertRedTrump(cards, trump);
    });
    test('customSort clubs', () {
      const trump = Suit.CLUBS;
      final cards = _buildCards(trump, true);
      cards.shuffle();

      // test
      Ranker(trump, Suit.UNKNOWN).customSortArray(cards);

      assertBlackTrump(cards, trump);
    });
    test('customSort spades', () {
      const trump = Suit.SPADES;
      final cards = _buildCards(trump, true);
      cards.shuffle();

      // test
      Ranker(trump, Suit.UNKNOWN).customSortArray(cards);

      assertBlackTrump(cards, trump);
    });
    void assertBlackNonTrump(List<Card> cards) {
      var i = 0;
      expect(cards[i++].ordinal, Ordinal.TEN);
      expect(cards[i++].ordinal, Ordinal.NINE);
      expect(cards[i++].ordinal, Ordinal.EIGHT);
      expect(cards[i++].ordinal, Ordinal.SEVEN);
      expect(cards[i++].ordinal, Ordinal.SIX);
      expect(cards[i++].ordinal, Ordinal.FOUR);
      expect(cards[i++].ordinal, Ordinal.THREE);
      expect(cards[i++].ordinal, Ordinal.TWO);
      expect(cards[i++].ordinal, Ordinal.QUEEN);
      expect(cards[i++].ordinal, Ordinal.KING);
      expect(cards[i++].ordinal, Ordinal.ACE);
      expect(cards[i++].ordinal, Ordinal.JACK);
      expect(cards[i++].ordinal, Ordinal.FIVE);
    }

    void assertRedNonTrump(List<Card> cards) {
      var i = 0;
      expect(cards[i++].ordinal, Ordinal.TWO);
      expect(cards[i++].ordinal, Ordinal.THREE);
      expect(cards[i++].ordinal, Ordinal.FOUR);
      expect(cards[i++].ordinal, Ordinal.SIX);
      expect(cards[i++].ordinal, Ordinal.SEVEN);
      expect(cards[i++].ordinal, Ordinal.EIGHT);
      expect(cards[i++].ordinal, Ordinal.NINE);
      expect(cards[i++].ordinal, Ordinal.TEN);
      expect(cards[i++].ordinal, Ordinal.QUEEN);
      expect(cards[i++].ordinal, Ordinal.KING);
      expect(cards[i++].ordinal, Ordinal.ACE);
      expect(cards[i++].ordinal, Ordinal.JACK);
      expect(cards[i++].ordinal, Ordinal.FIVE);
    }

    test('customSort clubs non-trump', () {
      const suit = Suit.CLUBS;
      final cards = _buildCards(suit, false);
      cards.shuffle();

      // test
      Ranker(suit, Suit.UNKNOWN).customSortArray(cards);

      assertBlackNonTrump(cards);
    });
    test('customSort spades non-trump', () {
      const suit = Suit.SPADES;
      final cards = _buildCards(suit, false);
      cards.shuffle();

      // test
      Ranker(suit, Suit.UNKNOWN).customSortArray(cards);

      assertBlackNonTrump(cards);
    });
    test('customSort diamonds non-trump', () {
      const suit = Suit.DIAMONDS;
      final cards = _buildCards(suit, false);
      cards.shuffle();

      // test
      Ranker(suit, Suit.UNKNOWN).customSortArray(cards);

      assertRedNonTrump(cards);
    });
    test('customSort hearts non-trump', () {
      const suit = Suit.HEARTS;
      final cards = _buildCards(suit, false);
      cards.shuffle();

      // test
      Ranker(suit, Suit.UNKNOWN).customSortArray(cards);

      assertRedNonTrump(cards);
    });
  }); // group
} // main
