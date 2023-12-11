import 'package:bowling_game/composable_frame.dart';

class FrameVisitor {
  int score = 0;
  int length = 0;
  bool isLastFrameCompleted = false;

  void execute(ComposableFrame frames) {
    length++;

    if (isEndGame(frames)) {
      isLastFrameCompleted = true;
    }

    score += frames.score();

    // BONUS
  }

  bool isEndGame(ComposableFrame frames) => length == 10 && frames.isLastRoll();
}
