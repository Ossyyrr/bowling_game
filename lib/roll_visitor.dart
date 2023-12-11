import 'package:bowling_game/composable_roll.dart';

class RollVisitor {
  int score = 0;
  int length = 0;

  bool isFirstRoll() => length == 1;
  bool isSecondRoll() => length == 2;

  void execute(ComposableRoll rolls) {
    score += rolls.score;
    length++;
  }
}
