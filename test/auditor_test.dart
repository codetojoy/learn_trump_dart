import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/models/config.dart';
import 'package:learn_trump_dart/models/deck.dart';
import 'package:learn_trump_dart/models/hand.dart';
import 'package:learn_trump_dart/models/table.dart';
import 'package:learn_trump_dart/models/player.dart';
import 'package:learn_trump_dart/services/auditor.dart';
import 'package:test/test.dart';

void main() {
  late var auditor;
  group('Auditor', () {
    setUp(() {
      auditor = Auditor();
    });
    test('audit: deck only', () {
      final deck = Deck();
      deck.shuffle();
      final table = Table([], deck);

      // test
      var result = auditor.audit(table);

      expect(result, true);
    });
    test('audit: deck, players', () {
      final deck = Deck();
      deck.shuffle();
      var players = Config.instance.getPlayers();
      final table = Table(players, deck);

      var card1 = deck.take(1)[0];
      players[0].dealHand(Hand().dealCard(card1));
      var card2 = deck.take(1)[0];
      players[1].dealHand(Hand().dealCard(card2));
      var card3 = deck.take(1)[0];
      players[2].dealHand(Hand().dealCard(card3));

      // test
      var result = auditor.audit(table);

      expect(result, true);
    });
    test('audit: deck, topCard', () {
      final deck = Deck();
      deck.shuffle();
      var players = <Player>[];
      final table = Table(players, deck);
      table.topCard = deck.take(1)[0];

      // test
      var result = auditor.audit(table);

      expect(result, true);
    });
    test('audit: deck, discards', () {
      final deck = Deck();
      deck.shuffle();
      var players = <Player>[];
      final table = Table(players, deck);
      final discardedCards = deck.take(5);
      table.discardedCards = discardedCards;

      // test
      var result = auditor.audit(table);

      expect(result, true);
    });
  }); // group
}
