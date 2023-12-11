import 'package:bowling_game/composable_roll.dart';
import 'package:bowling_game/roll_visitor.dart';

class ComposableFrame {
  final int _maxPins = 10;
  ComposableFrame? _nextFrame;
  final ComposableRoll _rolls = ComposableRoll();

  List<ComposableFrame> asList() {
    List<ComposableFrame> frames = [this];
    if (_nextFrame != null) {
      frames.addAll(_nextFrame!.asList());
    }
    return frames;
  }

  void execute(int pins) {
    if (_isCompleted()) {
      _createNextFrame().execute(pins);
      return;
    }
    pins = _checkMaxPinsTrap(pins);
    _rolls.execute(pins);
  }

  int score() => visitRolls().score;

  int _checkMaxPinsTrap(int pins) {
    if (_isOverMaxPins(pins)) {
      pins = _maxPins - score();
    }
    return pins;
  }

  ComposableFrame _createNextFrame() {
    _nextFrame ??= ComposableFrame();
    return _nextFrame!;
  }

  bool _isCompleted() => _isLastRoll();

  bool _isLastRoll() => visitRolls().length == 2;

  // bool get isStrike => rolls.length == 1 && score() == 10;
  // bool get isSpare => rolls.length == 2 && score() == 10;

  bool _isOverMaxPins(int pins) => score() + pins > _maxPins;

  RollVisitor visitRolls() {
    RollVisitor visitor = RollVisitor();
    _rolls.accept(visitor);
    return visitor;
  }
}
