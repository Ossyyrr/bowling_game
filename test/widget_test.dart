import 'package:bowling_game/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Game game;
  setUp(() {
    game = Game();
  });

  test('A game has 10 frames', () {
    for (int i = 0; i < 20; i++) {
      game.roll(3);
    }

    expect(game.score(), 60);

    game.roll(3);
    expect(game.score(), 60);
  });

  test('A frame has 2 rolls to knock down 10 pins', () {
    game.roll(3);
    game.roll(5);
    expect(game.score(), 8);

    game.roll(3);
    game.roll(9);
    expect(game.score(), 18);

    game.roll(13);
    game.roll(3);
    expect(game.score(), 44);

    game.roll(10);
    expect(game.score(), 58);
  });
  test(
      'The score for the frame is the total number of pins knocked down, plus bonuses for strikes and spares',
      () {});

  test(
      'Spare: A spare is when the player knocks down all 10 pins in two rolls. The bonus for that frame is the number of pins knocked down by the next roll.',
      () {
    game.roll(3);
    game.roll(7);
    expect(game.score(), 10);

    game.roll(3);
    expect(game.score(), 16);

    game.roll(2);
    expect(game.score(), 18);
  });

  test(
      'Strike: A strike is when the player knocks down all 10 pins on his first roll. The frame is then completed with a single roll. The bonus for that frame is the value of the next two rolls.',
      () {
    // Frame 1
    game.roll(10);
    expect(game.score(), 10);

    // Frame 2
    game.roll(3);
    expect(game.score(), 16);

    game.roll(2);
    expect(game.score(), 20);

    // Frame 3
    game.roll(10);
    expect(game.score(), 30);

    // Frame 4
    game.roll(10);
    expect(game.score(), 50);

    // Frame 5
    game.roll(4);
    expect(game.score(), 62);
  });

  test(
      'In the tenth frame a player who rolls a spare or strike is allowed to roll the extra balls to complete the frame. However no more than three balls can be rolled in tenth frame.',
      () {
    for (int i = 1; i < 10; i++) {
      game.roll(1);
      game.roll(4);
    }
    expect(game.score(), 45);

    game.roll(10);
    expect(game.score(), 55);

    game.roll(2);
    expect(game.score(), 57);

    game.roll(3);
    expect(game.score(), 60);
  });

  test('End Game', () {
    for (int i = 1; i < 10; i++) {
      game.roll(1);
      game.roll(4);
    }
    expect(game.score(), 45);

    // FRAME 10
    game.roll(2);
    expect(game.score(), 47);

    game.roll(2);
    expect(game.score(), 49);

    //END GAME
    game.roll(3);
    expect(game.score(), 49);
  });

  test('Game 1. Example', () {});
  test('Game 2. Example', () {});
}
