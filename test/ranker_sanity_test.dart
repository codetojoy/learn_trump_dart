import 'package:collection/collection.dart';
import 'package:test/test.dart';

import 'package:learn_trump_dart/models/card.dart';
import 'package:learn_trump_dart/models/cards.dart';
import 'package:learn_trump_dart/services/ranker.dart';

const CLUBS = Suit.CLUBS;
const DIAMONDS = Suit.DIAMONDS;
const HEARTS = Suit.HEARTS;
const SPADES = Suit.SPADES;
const UNKNOWN = Suit.UNKNOWN;

void main() {
  group('simple sanity check', () {
    test('sanity', () {
      final trumpSuit = CLUBS;
      final leadingSuit = CLUBS;
      final ranker = Ranker(trumpSuit, leadingSuit);
      final cards = <Card>[];
      cards.add(C.$5C);
      cards.add(C.$JC);
      cards.add(C.$AH);
      cards.add(C.$AC);
      cards.add(C.$KC);
      cards.add(C.$QC);
      cards.add(C.$2C);
      cards.shuffle();

      // test
      ranker.customSortArray(cards);
      final actual = cards.reversed.toList();

      var i = 0;
      expect(actual[i++], C.$5C);
      expect(actual[i++], C.$JC);
      expect(actual[i++], C.$AH);
      expect(actual[i++], C.$AC);
      expect(actual[i++], C.$KC);
      expect(actual[i++], C.$QC);
      expect(actual[i++], C.$2C);
    });
    test('sanity2', () {
      final trumpSuit = CLUBS;
      final leadingSuit = CLUBS;
      final ranker = Ranker(trumpSuit, leadingSuit);
      final cards = <Card>[];
      cards.add(C.$5C);
      cards.add(C.$JC);
      cards.add(C.$AH);
      cards.add(C.$AC);
      cards.add(C.$KC);
      cards.add(C.$QC);
      cards.add(C.$2C);
      cards.shuffle();

      // test
      ranker.customSortArray(cards);
      final actual = cards.reversed.toList();

      var i = 0;
      expect(actual[i++], C.$5C);
      expect(actual[i++], C.$JC);
      expect(actual[i++], C.$AH);
      expect(actual[i++], C.$AC);
      expect(actual[i++], C.$KC);
      expect(actual[i++], C.$QC);
      expect(actual[i++], C.$2C);
    });
    test('sanity3', () {
      final trumpSuit = CLUBS;
      final leadingSuit = HEARTS;
      final ranker = Ranker(trumpSuit, leadingSuit);
      final cards = <Card>[];
      cards.add(C.$AD);
      cards.add(C.$10S);
      cards.shuffle();

      // test
      ranker.customSortArray(cards);
      final actual = cards.reversed.toList();

      var i = 0;
      expect(actual[i++], C.$AD);
      expect(actual[i++], C.$10S);
    });
  }); // group
} // main
