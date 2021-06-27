import './deck.dart';
import './player.dart';
import './hand.dart';
import './strategy.dart';
import './table.dart';

class Config {
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

  Table getTable(Deck deck) {
    var table = Table(_players, deck);
    return table;
  }
}
