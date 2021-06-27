import '../models/bid.dart';
import '../models/config.dart';
import '../models/deck.dart';
import '../models/hand.dart';
import '../models/table.dart';
import '../models/player.dart';
import '../models/trick.dart';
import '../utils/constants.dart';
import './filter.dart';

class Dealer {
  void dealHands(Table table, Deck deck) {
    table.players.forEach((player) => dealHand(player, deck));
  }

  void dealHand(Player player, Deck deck) {
    final cards = deck.take(Const.NUM_CARDS_IN_HAND);
    final hand = Hand.provide(cards);
    player.dealHand(hand);
  }

  void playRound(Table table) {
    final trick = Trick(table.trumpSuit);
    var bids = getBids(table, trick);
    table.tricks.add(trick);
    print('TODO: play round');
  }

  List<Bid> getBids(Table table, Trick trick) {
    var bids = <Bid>[];
    var playerCount = 1;
    table.players.forEach((player) {
      if (playerCount == 1) {
        trick.leadingSuit = table.leadingSuit;
      }
      final filter = Filters().buildFilter(FilterType.proper);
      final cards = player.cards;
      final trumpSuit = trick.trumpSuit;
      final leadingSuit = trick.leadingSuit;
      final trumpPlayed = false;
      final candidates =
          filter.getCandidates(cards, trumpSuit, leadingSuit, trumpPlayed);
      var bid = player.getBid(trick, candidates);
      if (table.leadingCard.isUnknown) {
        table.leadingCard = bid.card;
      }
      bids.add(bid);
      table.discard(bid.card);
      playerCount++;
    });
    return bids;
  }
}
