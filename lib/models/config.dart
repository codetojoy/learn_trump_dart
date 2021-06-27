import './player.dart';
import './hand.dart';
import './strategy.dart';

enum Mode {
  mixed_cards,
  pure_suit,
}

class Config {
  static const int _numCards = 5;
  static const int _numRounds = 3;
  static const Mode _mode = Mode.pure_suit;
  final _players = <Player>[];

  List<Player> getPlayers() {
    return _players;
  }

  Config._() {
    final consoleStrategy = Strategies().buildStrategy(StrategyType.console);
    final nextStrategy = Strategies().buildStrategy(StrategyType.next_card);
    final p1 = Player('You', Hand(), true, consoleStrategy);
    final p2 = Player('Mozart', Hand(), false, nextStrategy);
    final p3 = Player('Chopin', Hand(), false, nextStrategy);
    _players.add(p1);
    _players.add(p2);
    _players.add(p3);
  }

  static Config instance = Config._();

  int get numCards => _numCards;
  Mode get mode => _mode;
  int get numRounds => _numRounds;
}
