import 'package:bowling_game/roll.dart';

class Frame {
  List<Roll> rolls = [];
  int maxPins = 10;
  int bonus = 0;

  void roll(int pins) {
    if (isOverMaxPins(pins)) {
      addRollWithMaxScore();
      return;
    }
    addRollScore(pins);
  }

  void addRollScore(int pins) => rolls.add(Roll(pins));

  void addRollWithMaxScore() => rolls.add(Roll(maxPins - score()));

  bool isOverMaxPins(int pins) => score() + pins > maxPins;

  bool morePinsThanMax(int pins) => rolls[0].score + pins > 10;

  bool get isFirstRoll => rolls.length == 1;

  int score() {
    if (rolls.isEmpty) return 0;
    return rolls.map((roll) => roll.score).reduce((a, b) => a + b);
  }
}
