enum Mode {
  mixed_cards,
  pure_suit,
}

class Config {
  static const int _numCards = 5;
  static const int _numRounds = 3;
  static const Mode _mode = Mode.pure_suit;

  Config._();

  static Config instance = Config._();

  int get numCards => _numCards;
  Mode get mode => _mode;
  int get numRounds => _numRounds;
}
