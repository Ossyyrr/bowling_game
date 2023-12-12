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
  }

  int totalScore() => score + bonus;

  void calculateBonus(ComposableFrame frames) {
    if (!existNextFrame(frames)) return;
    calculateSpare(frames);
    calculateStrike(frames);
  }

  void calculateSpare(ComposableFrame frames) {
    if (!frames.isSpare()) return;
    bonus += frames.nextFrame!.getFirstRollScore();
  }

  void calculateStrike(ComposableFrame frames) {
    if (!frames.isStrike()) return;

    if (!nextFrameIsStrike(frames)) {
      bonus += getNextFrameScore(frames);
      return;
    }

    bonus += frames.nextFrame!.getFirstRollScore();
    if (!existTwoFramesNext(frames)) return;
    bonus += frames.nextFrame!.nextFrame!.getFirstRollScore();
  }

  int getNextFrameScore(ComposableFrame frames) => frames.nextFrame!.score();
  bool existTwoFramesNext(ComposableFrame frames) =>
      frames.nextFrame!.nextFrame != null;
  bool existNextFrame(ComposableFrame frames) => frames.nextFrame != null;

  bool nextFrameIsStrike(ComposableFrame frames) =>
      frames.nextFrame!.isStrike();

  bool isEndGame(ComposableFrame frames) {
    if (isTenFrame) {
      if ((frames.isStrike() || frames.isSpare())) {
        return frames.visitRolls().hasThreeRolls();
      } else {
        return isTenFrame && frames.isSecondRoll();
      }
    }
    return false;
  }

  bool get isTenFrame => length == 10;
}
