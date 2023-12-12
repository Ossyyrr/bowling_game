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
    if (!existNextFrame(frames)) return;
    calculateSpare(frames);
    calculateStrike(frames);
  }

  void calculateSpare(ComposableFrame frames) {
    if (frames.isSpare()) {
      bonus += frames.nextFrame!.getFirstRollScore();
    }
  }

  void calculateStrike(ComposableFrame frames) {
    if (frames.isStrike()) {
      if (!nextFrameIsStrike(frames)) {
        bonus += getNextFrameScore(frames);
      }

      if (!existTwoFramesMore(frames)) return;

      if (nextFrameIsStrike(frames)) {
        bonus += getFirstRollScoreOfTwoNextFrames(frames);
      }
    }
  }

  int getFirstRollScoreOfTwoNextFrames(ComposableFrame frames) {
    return frames.nextFrame!.getFirstRollScore() +
        frames.nextFrame!.nextFrame!.getFirstRollScore();
  }

  int getNextFrameScore(ComposableFrame frames) => frames.nextFrame!.score();
  bool existTwoFramesMore(ComposableFrame frames) =>
      frames.nextFrame!.nextFrame != null;
  bool existNextFrame(ComposableFrame frames) => frames.nextFrame != null;

  bool nextFrameIsStrike(ComposableFrame frames) =>
      frames.nextFrame!.isStrike();
  bool isEndGame(ComposableFrame frames) => length == 10 && frames.isLastRoll();
}
