import '../models/card.dart';

abstract class Filter {
  List<Card> getCandidates(
      List<Card> cards, Suit trumpSuit, Suit leadingSuit, bool trumpPlayed);
}

enum FilterType {
  identity,
  proper,
}

class Filters {
  Filter buildFilter(FilterType filterType) {
    var filter;
    switch (filterType) {
      case FilterType.identity:
        filter = IdentityFilter();
        break;
      case FilterType.proper:
        filter = ProperFilter();
        break;
    }
    return filter;
  }
}

class IdentityFilter extends Filter {
  @override
  List<Card> getCandidates(
      List<Card> cards, Suit trumpSuit, Suit leadingSuit, bool trumpPlayed) {
    return cards;
  }
}

class ProperFilter extends Filter {
  bool containsSuit(List<Card> cards, Suit targetSuit) {
    return cards.where((card) => card.suit == targetSuit).isNotEmpty;
  }

  @override
  List<Card> getCandidates(
      List<Card> cards, Suit trumpSuit, Suit leadingSuit, bool trumpPlayed) {
    // default and no-op is all cards
    var filter = (card) => true;

    if (trumpSuit == Suit.UNKNOWN) {
      throw Exception('illegal state: no trump');
    }

    if (leadingSuit != Suit.UNKNOWN) {
      if (leadingSuit == trumpSuit) {
        if (containsSuit(cards, trumpSuit)) {
          // trump was led, player has trump and so must play
          // TODO: reneg rule
          filter = (card) => card.isTrump(trumpSuit);
        } else {
          // no-op
          // trump was led, but player doesn't have trump
        }
      } else {
        if (containsSuit(cards, trumpSuit) ||
            containsSuit(cards, leadingSuit)) {
          filter = (card) =>
              card.isTrump(trumpSuit) || card.isLeadingSuit(leadingSuit);
          // e.g. trump CLUBS, leading HEARTS
          // player can play trump or leading
        } else {
          // no-op
          // e.g. trump CLUBS, leading HEARTS
          // player doesn't have either so can play anything
        }
      }
    } else {
      // no-op
      // this is the opening play
    }

    final result = cards.where((card) => filter(card)).toList();
    return result;
  }
}
