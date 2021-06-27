import 'dart:io';

import './card.dart';
import './cards.dart';
import './hand.dart';
import './trick.dart';
import '../utils/logger.dart';

abstract class Strategy {
  Card selectCard(Hand hand, Trick trick, List<Card> candidates);

  void logInfo(Trick trick) {
    L.log('strategy $trick');
  }

  void confirmCandidates(Hand hand, List<Card> candidates) {
    if (candidates.isEmpty) {
      throw Exception('interal error: empty candidates');
    }
    var ok = hand.cards.length >= candidates.length;
    candidates.forEach((candidate) {
      ok = ok && hand.cards.contains(candidate);
    });
    if (!ok) {
      throw Exception('internal error: illegal subset $hand $candidates');
    }
  }
}

enum StrategyType {
  console,
  next_card,
}

class Strategies {
  Strategy buildStrategy(StrategyType strategyType) {
    var strategy;
    switch (strategyType) {
      case StrategyType.console:
        {
          strategy = _Console();
        }
        break;
      case StrategyType.next_card:
        {
          strategy = _NextCard();
        }
        break;
    }
    return strategy;
  }
}

class _NextCard extends Strategy {
  @override
  Card selectCard(Hand hand, Trick trick, List<Card> candidates) {
    logInfo(trick);
    confirmCandidates(hand, candidates);
    final result = candidates[0];
    L.log('next-card played: $result');
    return result;
  }
}

class _Console extends Strategy {
  @override
  Card selectCard(Hand hand, Trick trick, List<Card> candidates) {
    // logInfo(trick);
    confirmCandidates(hand, candidates);
    var choice = C.UNKNOWN;
    var done = false;

    while (!done) {
      stdout.writeln('');
      stdout.writeln('trick: $trick');
      stdout.writeln('your hand: $hand');
      stdout.writeln('candidates: $candidates');
      stdout.writeln('enter your choice: ');
      final input = stdin.readLineSync();
      if (input! == 'q') {
        print('ok ... quitting');
        exit(0);
      }
      final choiceIndex = int.parse(input);
      final ok = choiceIndex >= 1 && choiceIndex <= candidates.length;
      if (ok) {
        choice = candidates[choiceIndex - 1];
        done = true;
      } else {
        print('illegal choice');
      }
    }
    return choice;
  }
}
