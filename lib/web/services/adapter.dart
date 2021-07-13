import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/services/ranker.dart';
import './parser.dart';
import '../utils.dart';

// No HTTP dependencies here... just business logic

class Adapter {
  final _parser = Parser();

  // returns JSON: { 'cards': 'AH,2C,3D,5S' }
  String rank(String trumpStr, String leadingStr, String cardsStr) {
    var trump = _parser.parseSuit(trumpStr);
    if (trump == Suit.UNKNOWN) {
      throw Exception("unknown trump suit");
    }
    var leading = _parser.parseSuit(leadingStr);
    var cards = _parser.parseCards(cardsStr);
    final ranker = Ranker(trump, leading);
    ranker.customSortArray(cards);
    final result = _buildCardsString(cards.reversed.toList());
    return result;
  }

  String _buildCardsString(List<Card> cards) {
    var cardsStr = '';
    cards.forEach((card) => cardsStr += '$card,');
    cardsStr = cardsStr.substring(0, cardsStr.length - 1);
    return myJsonEncode('cards', cardsStr);
  }
}
