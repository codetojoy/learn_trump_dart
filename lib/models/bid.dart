import './card.dart';
import './player.dart';

class Bid {
  final Card card;
  final Player player;

  const Bid(this.card, this.player);

  @override
  String toString() {
    return '$player.name bids $card';
  }
}
