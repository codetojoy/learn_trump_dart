import 'dart:io';

import '../models/config.dart';
import '../models/card.dart';
import '../models/cards.dart';
import '../models/deck.dart';
import './ranker.dart';
import '../utils/constants.dart';

class Game {
  static const _ILLEGAL_SELECTION = -1;

  var _roundNum = 1;
  var _numCorrect = 0;

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

  int _getSelection(String input, int numCards) {
    var result = _ILLEGAL_SELECTION;
    final choiceIndex = int.parse(input);
    final ok = choiceIndex >= 1 && choiceIndex <= numCards;
    if (ok) {
      result = choiceIndex;
    }
    return result;
  }

  void playRound() {
    final trumpSuit = Suits().getRandom();
    final leadingSuit = Suits().getRandom();
    final cards = _getCards(trumpSuit);
    final numCards = Config.instance.numCards;
    final sortedCards = List<Card>.from(cards);
    Ranker(trumpSuit, leadingSuit).customSortArray(sortedCards);

    stdout.writeln('trumpSuit: $trumpSuit');
    stdout.writeln('leadingSuit: $leadingSuit');
    stdout.writeln('cards: $cards');
    stdout.writeln('sorted cards: $sortedCards');

    var done = false;
    var selection = C.UNKNOWN;
    var firstGuess = true;
    while (!done) {
      stdout.writeln('enter your choice (q to quit): ');
      final input = stdin.readLineSync();
      if (input! == 'q') {
        stdout.writeln('OK quitting...');
        exit(0);
      }
      final selectedIndex = _getSelection(input, numCards);
      final ok = selectedIndex != _ILLEGAL_SELECTION;
      if (ok) {
        selection = cards[selectedIndex - 1];
        done = true;
      } else {
        print('illegal choice');
      }
      if (selection == sortedCards[numCards - 1]) {
        stdout.writeln('correct!');
        if (firstGuess) {
          _numCorrect++;
        }
        stdout.writeln('$_numCorrect / $_roundNum');
      } else {
        stdout.writeln('try again');
      }
    }
    _roundNum++;
    firstGuess = false;
  }

  void play() {
    var done = false;
    _numCorrect = 0;
    _roundNum = 1;

    while (!done) {
      playRound();
      if (_roundNum == Config.instance.numRounds) {
        stdout.writeln('final score $_numCorrect / $_roundNum');
        done = true;
      }
    }
  }
}
