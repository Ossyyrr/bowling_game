import 'package:bowling_game/roll_visitor.dart';

class ComposableRoll {
  ComposableRoll? _nextRoll;
  int score = 0;
  bool _isCompleted = false;

  void execute(int pins) {
    if (_isCompleted) {
      _createNextRoll().execute(pins);
      return;
    }
    score = pins;
    _isCompleted = true;
  }

  void accept(RollVisitor visitor) {
    visitor.execute(this);
    _nextRoll?.accept(visitor);
  }

  ComposableRoll _createNextRoll() {
    _nextRoll ??= ComposableRoll();
    return _nextRoll!;
  }

  // List<ComposableRoll> asList() {
  //   List<ComposableRoll> rolls = [this];
  //   if (nextRoll != null) {
  //     rolls.addAll(nextRoll!.asList());
  //   }
  //   return rolls;
  // }
}
