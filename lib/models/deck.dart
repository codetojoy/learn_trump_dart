import './card.dart';
import './cards.dart';

class Deck {
  late final cards;

  Deck() {
    cards = List<Card>.from(C.allCards);
  }

  void shuffle() {
    cards.shuffle();
  }

  List<Card> take(int n) {
    var result = cards.take(n).toList();
    result.forEach((card) => cards.remove(card));
    return result;
  }
}
