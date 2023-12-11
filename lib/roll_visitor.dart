import 'package:bowling_game/composable_roll.dart';

class RollVisitor {
  int score = 0;
  int visits = 0;

  void execute(ComposableRoll rolls) {
    score += rolls.score;
    visits++;
  }
}