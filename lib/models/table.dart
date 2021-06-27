import './deck.dart';
import './player.dart';
import './card.dart';
import './cards.dart';
import './trick.dart';
import '../services/auditor.dart';

class Table {
  List<Player> players;
  Deck deck;
  Card topCard = C.UNKNOWN;
  List<Trick> tricks = [];
  Card leadingCard = C.UNKNOWN;
  int roundNum = 0;
  List<Card> discardedCards = <Card>[];

  Table(this.players, this.deck);

  void audit() {
    Auditor().audit(this);
  }

  void discard(Card card) {
    discardedCards.add(card);
  }

  Suit get leadingSuit {
    return leadingCard.suit;
  }

  Suit get trumpSuit {
    return topCard.suit;
  }

  @override
  String toString() {
    var result = '';
    if (topCard != null) {
      result += 'top: $topCard trump: $trumpSuit\n';
    }
    players.forEach((player) {
      result += '$player\n';
    });
    return result;
  }
}
