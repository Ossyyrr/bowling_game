import 'package:bowling_game/composable_roll.dart';
import 'package:bowling_game/roll_visitor.dart';

class Frame {
  int maxPins = 10;
  int bonus = 0;
  ComposableRoll rolls = ComposableRoll();

  void roll(int pins) {
    if (isOverMaxPins(pins)) {
      addRollWithMaxScore();
      return;
    }
    addRollScore(pins);
  }

  // bool get isStrike => rolls.length == 1 && score() == 10;
  // bool get isSpare => rolls.length == 2 && score() == 10;

  void addRollScore(int pins) {
    rolls.execute(pins);
  }

  void addRollWithMaxScore() {
    rolls.execute(maxPins - score());
  }

  bool isOverMaxPins(int pins) => score() + pins > maxPins;

  bool get isFirstRoll => visitRolls().visits == 1;

  int score() => visitRolls().score;

  RollVisitor visitRolls() {
    RollVisitor visitor = RollVisitor();
    rolls.accept(visitor);
    return visitor;
  }
}
