import 'package:test/test.dart';
import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/cross.dart';

main() {
  group('game tests', () {
    group('can play tests', () {
      test('game can\'t be played when no players have been set', () {
        final game = Game();
        expect(game.canPlay(), isFalse);
      });

      test('game can\'t be played with only one player set', () {
        final game = Game();
        game.addPlayer('Jairzinno');
        expect(game.canPlay(), isFalse);
      });

      test('game can be played with two players set', () {
        final game = _createGame();
        expect(game.canPlay(), isTrue);
      });
    });

    group('start test', () {
      test('game starts with no turns set', () {
        final game = _createGame();
        game.start();
        expect(game.turns, isEmpty);
      });

      test('game restarts with no turns set', () {
        final game = _createGame();
        game.start();
        expect(game.turns, isEmpty);
        game.addTurnForPosition(Position.topLeft);
        game.stop();
        game.addPlayer('Jairzinno');
        game.addPlayer('John');
        game.start();
        expect(game.turns, isEmpty);
      });
    });

    group('turn player tests', () {
      test('game doensn\'t change players without an explicit change', () {
        final game = _createGame();
        game.start();
        final firstTurn = game.addTurnForPosition(Position.topLeft);
        final secondTurn = game.addTurnForPosition(Position.topCenter);
        expect(firstTurn.player.name, 'Jairzinno');
        expect(secondTurn.player.name, 'Jairzinno');
      });

      test('game correctly changes players after a turn', () {
        Game game = _createGame();
        game.start();
        final firstTurn = game.addTurnForPosition(Position.topLeft);
        game.changePlayer();
        final secondTurn = game.addTurnForPosition(Position.topCenter);
        expect(firstTurn.player.name, 'Jairzinno');
        expect(secondTurn.player.name, 'John');
      });
    });

    group('position and turns tests', () {
      test('game returns a turn when it is valid', () {
        final game = _createGame();
        game.start();
        final turn = game.addTurnForPosition(Position.topCenter);
        expect(turn, isNotNull);
      });

      test('game returns null when a turn is not valid', () {
        final game = _createGame();
        game.start();
        final firstTurn = game.addTurnForPosition(Position.topCenter);
        expect(firstTurn, isNotNull);
        final secondTurn = game.addTurnForPosition(Position.topCenter);
        expect(secondTurn, isNull);
      });

      test('game returns null when the game ends with a draw', () {
        final game = _createGame();
        game.start();
        final positions = <Position>[
          Position.topLeft,
          Position.topCenter,
          Position.topRight,
          Position.centerLeft,
          Position.bottomLeft,
          Position.bottomCenter,
          Position.centerRight,
          Position.bottomRight,
          Position.center,
        ];
        positions.forEach((position) {
          final turn = game.addTurnForPosition(position);
          game.changePlayer();
          expect(turn, isNotNull, reason: position.toString());
        });

        final lastTurn = game.addTurnForPosition(Position.topCenter);
        expect(lastTurn, isNull);
      });

      test('game returns null when the game ends with a win', () {
        final game = _createGame();
        game.start();
        final positions = <Position>[
          Position.topLeft,
          Position.centerLeft,
          Position.topCenter,
          Position.bottomRight,
          Position.topRight,
        ];
        positions.forEach((position) {
          final turn = game.addTurnForPosition(position);
          game.changePlayer();
          expect(turn, isNotNull, reason: position.toString());
        });

        final lastTurn = game.addTurnForPosition(Position.topCenter);
        expect(lastTurn, isNull);
      });

      test('game returns correct shape for position', () {
        final game = _createGame();
        game.start();
        final positions = <Position>[
          Position.topLeft,
          Position.centerLeft,
          Position.topCenter,
          Position.bottomRight,
          Position.topRight,
        ];
        positions.forEach((position) {
          final turn = game.addTurnForPosition(position);
          game.changePlayer();
          expect(turn, isNotNull, reason: position.toString());
        });

        final shape = game.shapeForPosition(Position.topCenter);
        expect(shape.runtimeType, Cross(0).runtimeType);
      });
    });
  });
}

Game _createGame() {
  final game = Game();
  game.addPlayer('Jairzinno');
  game.addPlayer('John');
  return game;
}
