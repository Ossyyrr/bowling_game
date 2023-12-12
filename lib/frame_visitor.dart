import 'package:bowling_game/composable_frame.dart';

class FrameVisitor {
  int score = 0;
  int bonus = 0;
  int length = 0;
  bool isLastFrameCompleted = false;

  void execute(ComposableFrame frames) {
    length++;
    score += frames.score();
    calculateBonus(frames);

    if (isEndGame(frames)) {
      isLastFrameCompleted = true;
    }
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

    if (isNineFrame) {
      if (existNextFrame(frames) && nextFrameHasMoreThanOneRoll(frames)) {
        bonus += frames.nextFrame!.getFirstRollScore();
        bonus += frames.nextFrame!.getSecondRollScore();
        return;
      }
    }

    if (!nextFrameIsStrike(frames)) {
      bonus += getNextFrameScore(frames);
      return;
    }
    if (nextFrameIsStrike(frames)) {
      bonus += frames.nextFrame!.getFirstRollScore();
      if (!existTwoFramesNext(frames)) return;
      bonus += frames.nextFrame!.nextFrame!.getFirstRollScore();
    }
  }

  bool nextFrameHasMoreThanOneRoll(ComposableFrame frames) =>
      frames.nextFrame!.visitRolls().length > 1;

  int getNextFrameScore(ComposableFrame frames) => frames.nextFrame!.score();
  bool existTwoFramesNext(ComposableFrame frames) =>
      frames.nextFrame!.nextFrame != null;
  bool existNextFrame(ComposableFrame frames) => frames.nextFrame != null;
  bool nextFrameIsStrike(ComposableFrame frames) =>
      frames.nextFrame!.isStrike();
  bool isEndGame(ComposableFrame frames) => isTenFrame && frames.isCompleted();
  bool get isTenFrame => length == 10;
  bool get isNineFrame => length == 9;
}
