import './bid.dart';
import './card.dart';
import './hand.dart';
import './strategy.dart';
import './trick.dart';

class Player {
  late String name;
  late Hand _hand;
  late bool _interactive;
  late Strategy _strategy;

  Player(String name, Hand hand, bool interactive, Strategy strategy) {
    this.name = name;
    _hand = hand;
    _interactive = interactive;
    _strategy = strategy;
  }

  Player.simple(String name) {
    this.name = name;
    _hand = Hand();
    _interactive = false;
    _strategy = Strategies().buildStrategy(StrategyType.next_card);
  }

  List<Card> get cards {
    return _hand.cards;
  }

  void dealHand(Hand hand) {
    _hand = hand;
  }

  bool handContainsCardOfSuit(Suit suit) {
    return _hand.containsCardOfSuit(suit);
  }

  Bid getBid(Trick trick, List<Card> candidates) {
    final card = _strategy.selectCard(_hand, trick, candidates);
    final bid = Bid(card, this);
    _hand = _hand.removeCard(card);
    return bid;
  }

  @override
  String toString() {
    return '$name $_hand';
  }
}
