import 'package:bowling_game/composable_frame.dart';

class Game {
  ComposableFrame frames = ComposableFrame();

  void roll(int pins) {
    if (_isEndGame()) return;
    _actualFrame().execute(pins);
  }

  int score() =>
      frames.asList().map((frame) => frame.score()).reduce((a, b) => a + b);

  ComposableFrame _actualFrame() => frames.asList().last;

  bool _isEndGame() =>
      frames.asList().length == 10 &&
      frames.asList()[9].visitRolls().length == 2;
}
