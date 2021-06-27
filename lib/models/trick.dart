import './card.dart';
import './bid.dart';

enum TrickState {
  UNKNOWN, // = 0,
  NEW, // = 1,
  LEADING_NO_TRUMP, // = 2,
  TRUMP_PLAYED, // = 3,
}

class Trick {
  Suit trumpSuit = Suit.UNKNOWN;
  Suit leadingSuit = Suit.UNKNOWN;
  TrickState trickState = TrickState.UNKNOWN;
  // bool _hasTrumpBeenPlayed;
  // Bid _winningBid;
  // int _pointValue;
  List<Bid> bids = [];

  Trick(this.trumpSuit);
  Trick.multi(this.trumpSuit, this.leadingSuit, this.trickState);

  @override
  String toString() {
    var result = 'trump: $trumpSuit\n';
    result += 'leading: $leadingSuit\n';
    bids.forEach((bid) {
      result += 'bid: $bid\n';
    });
    return result;
  }
}
