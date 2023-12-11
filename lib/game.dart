import 'package:bowling_game/frame.dart';

class Game {
  List<Frame> frames = [Frame()];
  int currentFrame = 0;

  void roll(int pins) {
    if (isEndGame()) return;

    if (isLastRoll()) {
      nextFrame();
    }
    actualFrame().roll(pins);
  }

  bool isLastRoll() => actualFrame().visitRolls().length == 2;

  void nextFrame() {
    currentFrame++;
    frames.add(Frame());
  }

  Frame actualFrame() => frames[currentFrame];

  int score() => frames.map((frame) => frame.score()).reduce((a, b) => a + b);

  bool isEndGame() => frames.length == 10 && frames[9].visitRolls().length == 2;
}
