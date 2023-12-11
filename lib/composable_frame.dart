import 'package:bowling_game/composable_roll.dart';
import 'package:bowling_game/roll_visitor.dart';

class ComposableFrame {
  int maxPins = 10;
  ComposableFrame? nextFrame;
  ComposableRoll rolls = ComposableRoll();

  List<ComposableFrame> asList() {
    List<ComposableFrame> frames = [this];
    if (nextFrame != null) {
      frames.addAll(nextFrame!.asList());
    }
    return frames;
  }

  void execute(int pins) {
    if (_isCompleted()) {
      createNextFrame().execute(pins);
      return;
    }
    pins = checkMaxPinsTrap(pins);
    rolls.execute(pins);
  }

  int checkMaxPinsTrap(int pins) {
    if (isOverMaxPins(pins)) {
      pins = maxPins - score();
    }
    return pins;
  }

  ComposableFrame createNextFrame() {
    nextFrame ??= ComposableFrame();
    return nextFrame!;
  }

  bool _isCompleted() => isLastRoll() && rolls.isCompleted;

  bool isLastRoll() => visitRolls().length == 2;

  // bool get isStrike => rolls.length == 1 && score() == 10;
  // bool get isSpare => rolls.length == 2 && score() == 10;

  bool isOverMaxPins(int pins) => score() + pins > maxPins;

  bool get isFirstRoll => visitRolls().length == 1;

  int score() => visitRolls().score;

  RollVisitor visitRolls() {
    RollVisitor visitor = RollVisitor();
    rolls.accept(visitor);
    return visitor;
  }
}
