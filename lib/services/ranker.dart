import '../models/bid.dart';
import '../models/card.dart';
import '../models/cards.dart';

class RankInfo {
  final card;
  final rank;

  const RankInfo(this.card, this.rank);
}

abstract class _BaseMap {
  static const maxRankCeiling = 18;
  final Map<int, int> _map = {};

  void setCard(RankInfo info) {
    final id = info.card.id;
    _map[id] = info.rank;
  }

  void setCards(List<RankInfo> infos) {
    infos.forEach((info) => setCard(info));
  }

  int getAt(int id) {
    return _map[id]!;
  }
}

class _OffsuitBlackMap extends _BaseMap {
  _OffsuitBlackMap() {
    // off-suit CLUBS
    const cards1 = [
      RankInfo(C.$10C, 1),
      RankInfo(C.$9C, 2),
      RankInfo(C.$8C, 3),
      RankInfo(C.$7C, 4),
      RankInfo(C.$6C, 5),
      RankInfo(C.$5C, 6),
      RankInfo(C.$4C, 7),
      RankInfo(C.$3C, 8),
      RankInfo(C.$2C, 9),
      RankInfo(C.$AC, 10),
      RankInfo(C.$JC, 11),
      RankInfo(C.$QC, 12),
      RankInfo(C.$KC, 13),
    ];
    setCards(cards1);

    // off-suit SPADES
    const cards2 = [
      RankInfo(C.$10S, 1),
      RankInfo(C.$9S, 2),
      RankInfo(C.$8S, 3),
      RankInfo(C.$7S, 4),
      RankInfo(C.$6S, 5),
      RankInfo(C.$5S, 6),
      RankInfo(C.$4S, 7),
      RankInfo(C.$3S, 8),
      RankInfo(C.$2S, 9),
      RankInfo(C.$AS, 10),
      RankInfo(C.$JS, 11),
      RankInfo(C.$QS, 12),
      RankInfo(C.$KS, 13),
    ];
    setCards(cards2);
  }
} // _OffsuitBlackMap

class _OffsuitRedMap extends _BaseMap {
  _OffsuitRedMap() {
    // off-suit DIAMONDS
    const cards1 = [
      RankInfo(C.$AD, 1),
      RankInfo(C.$2D, 2),
      RankInfo(C.$3D, 3),
      RankInfo(C.$4D, 4),
      RankInfo(C.$5D, 5),
      RankInfo(C.$6D, 6),
      RankInfo(C.$7D, 7),
      RankInfo(C.$8D, 8),
      RankInfo(C.$9D, 9),
      RankInfo(C.$10D, 10),
      RankInfo(C.$JD, 11),
      RankInfo(C.$QD, 12),
      RankInfo(C.$KD, 13),
    ];
    setCards(cards1);

    // off-suit HEARTS
    const cards2 = [
      RankInfo(C.$AH, 1),
      RankInfo(C.$2H, 2),
      RankInfo(C.$3H, 3),
      RankInfo(C.$4H, 4),
      RankInfo(C.$5H, 5),
      RankInfo(C.$6H, 6),
      RankInfo(C.$7H, 7),
      RankInfo(C.$8H, 8),
      RankInfo(C.$9H, 9),
      RankInfo(C.$10H, 10),
      RankInfo(C.$JH, 11),
      RankInfo(C.$QH, 12),
      RankInfo(C.$KH, 13),
    ];
    setCards(cards2);
  }
}

class _TrumpClubsMap extends _BaseMap {
  _TrumpClubsMap() {
    // trump CLUBS
    const cards = [
      RankInfo(C.$10C, 1),
      RankInfo(C.$9C, 2),
      RankInfo(C.$8C, 3),
      RankInfo(C.$7C, 4),
      RankInfo(C.$6C, 5),
      // { 6 }
      RankInfo(C.$4C, 7),
      RankInfo(C.$3C, 8),
      RankInfo(C.$2C, 9),
      // { 10 }
      // { 11 }
      RankInfo(C.$QC, 12),
      RankInfo(C.$KC, 13),
      RankInfo(C.$AC, 14),
      RankInfo(C.$AH, 15),
      RankInfo(C.$JC, 16),
      RankInfo(C.$5C, 17),
    ];
    setCards(cards);
  }
}

class _TrumpSpadesMap extends _BaseMap {
  _TrumpSpadesMap() {
    // trump SPADES
    const cards = [
      RankInfo(C.$10S, 1),
      RankInfo(C.$9S, 2),
      RankInfo(C.$8S, 3),
      RankInfo(C.$7S, 4),
      RankInfo(C.$6S, 5),
      // { 6 }
      RankInfo(C.$4S, 7),
      RankInfo(C.$3S, 8),
      RankInfo(C.$2S, 9),
      // { 10 }
      // { 11 }
      RankInfo(C.$QS, 12),
      RankInfo(C.$KS, 13),
      RankInfo(C.$AS, 14),
      RankInfo(C.$AH, 15),
      RankInfo(C.$JS, 16),
      RankInfo(C.$5S, 17),
    ];

    setCards(cards);
  }
}

class _TrumpDiamondsMap extends _BaseMap {
  _TrumpDiamondsMap() {
    // trump DIAMONDS
    const cards = [
      RankInfo(C.$2D, 2),
      RankInfo(C.$3D, 3),
      RankInfo(C.$4D, 4),
      // { 5 }
      RankInfo(C.$6D, 6),
      RankInfo(C.$7D, 7),
      RankInfo(C.$8D, 8),
      RankInfo(C.$9D, 9),
      RankInfo(C.$10D, 10),
      // { 11 }
      RankInfo(C.$QD, 12),
      RankInfo(C.$KD, 13),
      RankInfo(C.$AD, 14),
      RankInfo(C.$AH, 15),
      RankInfo(C.$JD, 16),
      RankInfo(C.$5D, 17),
    ];

    setCards(cards);
  }
}

class _TrumpHeartsMap extends _BaseMap {
  _TrumpHeartsMap() {
    // trump HEARTS
    const suit = Suit.HEARTS;
    const cards = [
      RankInfo(C.$2H, 2),
      RankInfo(C.$3H, 3),
      RankInfo(C.$4H, 4),
      // { 5 }
      RankInfo(C.$6H, 6),
      RankInfo(C.$7H, 7),
      RankInfo(C.$8H, 8),
      RankInfo(C.$9H, 9),
      RankInfo(C.$10H, 10),
      // { 11 }
      RankInfo(C.$QH, 12),
      RankInfo(C.$KH, 13),
      // { 14 }
      RankInfo(C.$AH, 15),
      RankInfo(C.$JH, 16),
      RankInfo(C.$5H, 17),
    ];

    setCards(cards);
  }
}

class Ranker {
  static const unknownValue = -1;
  static const trumpSuitFactor = 1000;
  static const leadingSuitFactor = 100;
  var _trumpSuit = Suit.UNKNOWN;
  var _leadingSuit = Suit.UNKNOWN;

  final _offSuitBlack = _OffsuitBlackMap();
  final _offSuitRed = _OffsuitRedMap();

  final _trumpClubs = _TrumpClubsMap();
  final _trumpSpades = _TrumpSpadesMap();

  final _trumpDiamonds = _TrumpDiamondsMap();
  final _trumpHearts = _TrumpHeartsMap();

  Ranker(this._trumpSuit, this._leadingSuit);

  int compare(int a, int b) {
    return a == b
        ? 0
        : a > b
            ? 1
            : -1;
  }

  void customSortArray(List<Card> cards) {
    cards.sort((a, b) => customSort(a, b));
  }

  void customSortBids(List<Bid> bids) {
    bids.sort((a, b) => customSort(a.card, b.card));
  }

  int getValueFromId(Card card) {
    var value = unknownValue;
    final id = card.id;

    if (card.isTrump(_trumpSuit)) {
      if (card.suit == Suit.CLUBS || card.isAceOfHearts) {
        value = _trumpClubs.getAt(id);
      } else if (card.suit == Suit.SPADES || card.isAceOfHearts) {
        value = _trumpSpades.getAt(id);
      } else if (card.suit == Suit.DIAMONDS || card.isAceOfHearts) {
        value = _trumpDiamonds.getAt(id);
      } else if (card.suit == Suit.HEARTS) {
        value = _trumpHearts.getAt(id);
      }
    } else {
      if (card.isBlack) {
        value = _offSuitBlack.getAt(id);
      } else if (card.isRed) {
        value = _offSuitRed.getAt(id);
      }
    }

    return value;
  }

  int customSort(Card cardA, Card cardB) {
    var valueA = getValueFromId(cardA);
    var valueB = getValueFromId(cardB);

    if (valueA == unknownValue || valueB == unknownValue) {
      throw Exception('internal error ${cardA} ${cardB}');
    }

    final isCardATrump = cardA.isTrump(_trumpSuit);
    final isCardBTrump = cardB.isTrump(_trumpSuit);

    final isCardALeadingSuit = cardA.isLeadingSuit(_leadingSuit);
    final isCardBLeadingSuit = cardB.isLeadingSuit(_leadingSuit);

    if (isCardATrump) {
      valueA += trumpSuitFactor;
    }
    if (isCardBTrump) {
      valueB += trumpSuitFactor;
    }
    if (isCardALeadingSuit) {
      valueA += leadingSuitFactor;
    }
    if (isCardBLeadingSuit) {
      valueB += leadingSuitFactor;
    }

    final result = compare(valueA, valueB);

    return result;
  }
}
