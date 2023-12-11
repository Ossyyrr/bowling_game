import 'package:bowling_game/composable_frame.dart';
import 'package:bowling_game/frame_visitor.dart';

class Game {
  ComposableFrame frames = ComposableFrame();

  void roll(int pins) {
    if (_isEndGame()) return;
    frames.execute(pins);
  }

  int score() => visitFrames().totalScore();

  bool _isEndGame() => visitFrames().isLastFrameCompleted;

  FrameVisitor visitFrames() {
    FrameVisitor visitor = FrameVisitor();
    frames.accept(visitor);
    return visitor;
  }
}
