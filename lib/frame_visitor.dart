import 'package:bowling_game/composable_frame.dart';

class FrameVisitor {
  int score = 0;
  int bonus = 0;
  int length = 0;
  bool isLastFrameCompleted = false;

  void execute(ComposableFrame frames) {
    length++;

    if (isEndGame(frames)) {
      isLastFrameCompleted = true;
    }

    score += frames.score();

    calculateBonus(frames);

    // BONUS
  }

  int totalScore() => score + bonus;

  void calculateBonus(ComposableFrame frames) {
    if (frames.nextFrame != null) {
      if (frames.isSpare()) {
        bonus += frames.nextFrame!.rolls.score;
      }
    }

    // if (frames.isStrike()) {
    //   bonus += frames.nextFrame!.visitRolls().score;
    // }
  }

  bool isEndGame(ComposableFrame frames) => length == 10 && frames.isLastRoll();
}
