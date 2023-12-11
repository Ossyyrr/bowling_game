import 'package:bowling_game/composable_roll.dart';
import 'package:bowling_game/frame_visitor.dart';
import 'package:bowling_game/roll_visitor.dart';

class ComposableFrame {
  final int _maxPins = 10;
  ComposableFrame? _nextFrame;
  final ComposableRoll _rolls = ComposableRoll();

  void execute(int pins) {
    if (_isCompleted()) {
      _createNextFrame().execute(pins);
      return;
    }
    pins = _checkMaxPinsTrap(pins);
    _rolls.execute(pins);
  }

  void accept(FrameVisitor visitor) {
    visitor.execute(this);
    _nextFrame?.accept(visitor);
  }

  int score() => _visitRolls().score;

  int _checkMaxPinsTrap(int pins) {
    if (_isOverMaxPins(pins)) {
      pins = _maxPins - score();
    }
    return pins;
  }

  bool isLastRoll() => _visitRolls().length == 2;

  ComposableFrame _createNextFrame() {
    _nextFrame ??= ComposableFrame();
    return _nextFrame!;
  }

  bool _isCompleted() => _isLastRoll();

  bool _isLastRoll() => _visitRolls().length == 2;

  // bool get isStrike => rolls.length == 1 && score() == 10;
  // bool get isSpare => rolls.length == 2 && score() == 10;

  bool _isOverMaxPins(int pins) => score() + pins > _maxPins;

  RollVisitor _visitRolls() {
    RollVisitor visitor = RollVisitor();
    _rolls.accept(visitor);
    return visitor;
  }
}
