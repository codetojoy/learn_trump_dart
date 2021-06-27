import 'dart:io';

import '../models/config.dart';
import '../models/card.dart';
import '../models/cards.dart';
import '../models/deck.dart';
import './ranker.dart';
import '../utils/constants.dart';

class RoundInfo {
  var firstGuess = true;
  var roundNum = 1;
  var numCorrect = 0;

  RoundInfo.init() {}

  RoundInfo(this.firstGuess, this.roundNum, this.numCorrect);

  bool isDone(int numRounds) {
    return roundNum >= numRounds;
  }

  RoundInfo nextRound() {
    return RoundInfo(true, roundNum + 1, numCorrect);
  }

  RoundInfo correctGuess() {
    final newNumCorrect = (firstGuess) ? numCorrect + 1 : numCorrect;
    return RoundInfo(firstGuess, roundNum, newNumCorrect);
  }

  RoundInfo wrongGuess() {
    return RoundInfo(false, roundNum, numCorrect);
  }

  @override
  String toString() {
    return '$numCorrect / $roundNum';
  }
}

class Game {
  List<Card> _getCards(Suit trumpSuit) {
    var cards;
    final numCards = Config.instance.numCards;
    if (Config.instance.mode == Mode.mixed_cards) {
      final deck = Deck();
      deck.shuffle();
      cards = deck.take(numCards);
    } else {
      cards = C.getRandomBySuit(trumpSuit, numCards);
    }
    return cards;
  }

  Card _getSelection(List<Card> cards) {
    var result = C.UNKNOWN;
    var done = false;

    while (!done) {
      stdout.writeln('enter your choice (q to quit): ');
      final input = stdin.readLineSync();
      if (input! == 'q') {
        stdout.writeln('OK quitting...');
        exit(0);
      }
      final choiceIndex = int.parse(input);
      final ok = choiceIndex >= 1 && choiceIndex <= cards.length;
      if (ok) {
        result = cards[choiceIndex - 1];
        done = true;
      } else {
        stdout.writeln('illegal choice');
      }
    }
    return result;
  }

  RoundInfo playRound(RoundInfo inRoundInfo) {
    var roundInfo = inRoundInfo;
    final trumpSuit = Suits().getRandom();
    final leadingSuit = Suits().getRandom();
    final cards = _getCards(trumpSuit);
    final numCards = Config.instance.numCards;
    final sortedCards = List<Card>.from(cards);
    Ranker(trumpSuit, leadingSuit).customSortArray(sortedCards);

    var done = false;

    while (!done) {
      stdout.writeln('trumpSuit: $trumpSuit');
      stdout.writeln('leadingSuit: $leadingSuit');
      stdout.writeln('cards: $cards');
      stdout.writeln('sorted cards: $sortedCards');

      final selection = _getSelection(cards);

      if (selection == sortedCards[numCards - 1]) {
        stdout.writeln('correct!');
        roundInfo = roundInfo.correctGuess();
        stdout.writeln('$roundInfo');
        done = true;
      } else {
        stdout.writeln('try again');
        roundInfo = roundInfo.wrongGuess();
      }
    }

    return roundInfo;
  }

  void play() {
    var done = false;
    var roundInfo = RoundInfo.init();

    while (!done) {
      roundInfo = playRound(roundInfo);
      if (roundInfo.isDone(Config.instance.numRounds)) {
        stdout.writeln('final score $roundInfo');
        done = true;
      } else {
        roundInfo = roundInfo.nextRound();
      }
    }
  }
}
