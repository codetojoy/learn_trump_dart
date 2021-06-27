import 'package:test/test.dart';

import 'package:learn_trump_dart/models/bid.dart';
import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/models/player.dart';
import 'package:learn_trump_dart/services/ranker.dart';

void main() {
  group('Ranker', () {
    Bid b(String name, Card card) {
      final player = Player.simple(name);
      final bid = Bid(card, player);
      return bid;
    }

    test('bids', () {
      final trumpSuit = Suit.CLUBS;
      final leadingSuit = Suit.DIAMONDS;
      final bids = [
        b('mozart', C.$KS),
        b('chopin', C.$AH),
        b('beethoven', C.$5C),
        b('liszt', C.$2D),
      ];

      bids.shuffle();

      // test
      new Ranker(trumpSuit, leadingSuit).customSortBids(bids);

      var i = 0;
      expect(bids[i++].player.name, 'mozart');
      expect(bids[i++].player.name, 'liszt');
      expect(bids[i++].player.name, 'chopin');
      expect(bids[i++].player.name, 'beethoven');
    });
  }); // group
} // main
