import 'package:bowling_game/composable_roll.dart';

class RollVisitor {
  int score = 0;
  int length = 0;

  bool hasOneRoll() => length == 1;
  bool hasTwoRolls() => length == 2;
  bool hasThreeRolls() => length == 3;

  void execute(ComposableRoll rolls) {
    score += rolls.score;
    length++;
  }
}
