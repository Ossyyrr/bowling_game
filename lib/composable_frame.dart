import 'package:bowling_game/composable_roll.dart';
import 'package:bowling_game/frame_visitor.dart';
import 'package:bowling_game/roll_visitor.dart';

class ComposableFrame {
  ComposableFrame({this.frameCount = 1});
  int frameCount;

  final int _maxPins = 10;
  ComposableFrame? nextFrame;
  final ComposableRoll rolls = ComposableRoll();

  void execute(int pins) {
    if (isCompleted()) {
      _createNextFrame().execute(pins);
      return;
    }
    pins = _checkMaxPinsTrap(pins);
    rolls.execute(pins);
  }

  int getFirstRollScore() => rolls.score;
  int getSecondRollScore() => rolls.nextRoll!.score;

  void accept(FrameVisitor visitor) {
    visitor.execute(this);

    nextFrame?.accept(visitor);
  }

  int _checkMaxPinsTrap(int pins) {
    if (_isOverMaxPins(pins) && !isTenFrame()) {
      pins = _maxPins - score();
    }
    return pins;
  }

  ComposableFrame _createNextFrame() {
    nextFrame ??= ComposableFrame(frameCount: frameCount + 1);
    return nextFrame!;
  }

  bool isCompleted() {
    if (!isTenFrame()) {
      return isSecondRoll() || isStrike();
    }

    if (isTenFrame()) {
      if (isSpare() || isStrike()) {
        return visitRolls().hasThreeRolls();
      }
      return isSecondRoll();
    }

    return false;
  }

  bool isSecondRoll() => visitRolls().length == 2;
  bool isTenFrame() => frameCount == 10;
  int score() => visitRolls().score;
  bool _isOverMaxPins(int pins) => score() + pins > _maxPins;

  bool isSpare() => visitRolls().length == 2 && score() == 10;
  bool isStrike() => rolls.score == 10;

  RollVisitor visitRolls() {
    RollVisitor visitor = RollVisitor();
    rolls.accept(visitor);
    return visitor;
  }
}
