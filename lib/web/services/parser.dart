import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/web/keys.dart';

class Parser {
  Suit parseSuit(String s) {
    var result = Suit.UNKNOWN;
    final t = s.trim().toUpperCase();
    switch (t) {
      case Keys.C:
        result = Suit.CLUBS;
        break;
      case Keys.D:
        result = Suit.DIAMONDS;
        break;
      case Keys.H:
        result = Suit.HEARTS;
        break;
      case Keys.D:
        result = Suit.SPADES;
        break;
      default:
        break;
    }
    return result;
  }

  // This is not efficient but simpler than parsing right now.
  Card parseCard(String s) {
    final t = s.trim().toUpperCase();

    // throw state error if not found:
    var result = C.allCards.firstWhere((card) => card.toString() == t);

    return result;
  }

  List<Card> parseCards(String s) {
    return s
        .split(Keys.COMMA)
        .map<Card>((String cardStr) => parseCard(cardStr))
        .toList();
  }
}
