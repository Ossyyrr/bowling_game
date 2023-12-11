import 'package:bowling_game/composable_frame.dart';

class Game {
  ComposableFrame frames = ComposableFrame();
  int currentFrame = 0;

  void roll(int pins) {
    if (isEndGame()) return;
    actualFrame().execute(pins);
  }

  void nextFrame() {
    currentFrame++;
    frames.asList().add(ComposableFrame());
  }

  bool isLastRoll() => actualFrame().visitRolls().length == 2;

  ComposableFrame actualFrame() => frames.asList().last;

  int score() =>
      frames.asList().map((frame) => frame.score()).reduce((a, b) => a + b);

  bool isEndGame() =>
      frames.asList().length == 10 &&
      frames.asList()[9].visitRolls().length == 2;
}
