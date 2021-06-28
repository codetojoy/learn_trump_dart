import 'dart:io';

import '../models/config.dart';
import '../models/card.dart';
import '../models/cards.dart';
import '../models/deck.dart';
import './ranker.dart';

class RoundInfo {
  var firstGuess = true;
  var roundNum = 1;
  var numCorrect = 0;
  var _numRounds = 0;

  RoundInfo.init(int numRounds) {
    _numRounds = numRounds;
  }

  RoundInfo(this.firstGuess, this.roundNum, this.numCorrect, this._numRounds);

  bool isDone() {
    return roundNum > _numRounds;
  }

  RoundInfo nextRound() {
    return RoundInfo(true, roundNum + 1, numCorrect, _numRounds);
  }

  RoundInfo correctGuess() {
    final newNumCorrect = (firstGuess) ? numCorrect + 1 : numCorrect;
    return RoundInfo(firstGuess, roundNum, newNumCorrect, _numRounds);
  }

  RoundInfo wrongGuess() {
    return RoundInfo(false, roundNum, numCorrect, _numRounds);
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
    final ranker = Ranker(trumpSuit, leadingSuit);
    final topCards = ranker.getTopRankedCards(cards);

    var done = false;

    while (!done) {
      stdout.writeln('trumpSuit: $trumpSuit');
      stdout.writeln('leadingSuit: $leadingSuit');
      stdout.writeln('cards: $cards');

      if (Config.instance.debug) {
        stdout.writeln('top cards: $topCards');
        var sortedCards = List<Card>.from(cards);
        ranker.customSortArray(sortedCards);
        stdout.writeln('sorted cards: $sortedCards');
      }

      final selection = _getSelection(cards);

      if (topCards.contains(selection)) {
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
    var roundInfo = RoundInfo.init(Config.instance.numRounds);

    while (!roundInfo.isDone()) {
      roundInfo = playRound(roundInfo);
      if (roundInfo.isDone()) {
        stdout.writeln('final score $roundInfo');
      } else {
        roundInfo = roundInfo.nextRound();
      }
    }
  }
}
