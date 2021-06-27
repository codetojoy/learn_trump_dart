import './card.dart';

class Hand {
  List<Card> _cards = [];

  Hand() {}

  Hand.provide(List<Card> cards) {
    _cards = cards;
  }

  get cards => _cards;

  Hand removeCard(Card card) {
    _cards.remove(card);
    return this;
  }

  Hand dealCard(Card card) {
    _cards.add(card);
    return this;
  }

  bool containsCardOfSuit(Suit suit) {
    return _cards.where((card) => card.suit == suit).isNotEmpty;
  }

  @override
  String toString() {
    var result = '';
    _cards.forEach((card) {
      result += ' $card';
    });
    return result;
  }
}
