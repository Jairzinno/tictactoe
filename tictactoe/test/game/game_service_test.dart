import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/game/position.dart';

import '../mock.dart';

main() {
  group('game service tests', () {
    GameService sut;
    MockStreamSink mockSink;
    MockStreamController mockStreamController;
    MockGame mockGame;

    setUp(() {
      sut = GameService();
      mockGame = MockGame();
      mockSink = MockStreamSink();
      mockStreamController = MockStreamController();
      when(mockStreamController.sink).thenReturn(mockSink);
    });

    test('game service does not play without players', () {
      sut.setup(Game(), mockStreamController);
      expect(sut.needPlayer(), isTrue);
      sut.addPlayer('Jairzinno');
      expect(sut.needPlayer(), isTrue);
      sut.addPlayer('John');
      expect(sut.needPlayer(), isFalse);
    });

    test('game service start a new game', () {
      sut.setup(mockGame, mockStreamController);
      sut.start();
      verify(mockGame.start());
    });

    test('game service adds a valid turn to the history of turns', () {
      sut.setup(Game(), mockStreamController);
      sut.addPlayer('Jairzinno');
      sut.addPlayer('John');
      sut.start();
      sut.positionTapped(Position.topLeft);
      verify(mockSink.add(any));
    });

    test('game service does not add an invalid turn to the history of turns',
        () {
      sut.setup(mockGame, mockStreamController);
      when(mockGame.addTurnForPosition(any)).thenReturn(null);
      sut.positionTapped(Position.topLeft);
      verifyNever(mockSink.add(any));
    });

    test('game service changes players after a valid turn', () {
      sut.setup(mockGame, mockStreamController);
      final mockTurn = MockTurn();
      when(mockGame.turns).thenReturn([mockTurn]);
      when(mockGame.addTurnForPosition(any)).thenReturn(mockTurn);
      when(mockTurn.draw).thenReturn(false);
      when(mockTurn.win).thenReturn(false);
      sut.positionTapped(Position.topLeft);
      verify(mockGame.changePlayer());
    });

    test('game service does not change players after a winning turn', () {
      sut.setup(mockGame, mockStreamController);
      final mockTurn = MockTurn();
      when(mockGame.turns).thenReturn([mockTurn]);
      when(mockGame.addTurnForPosition(any)).thenReturn(mockTurn);
      when(mockTurn.draw).thenReturn(false);
      when(mockTurn.win).thenReturn(true);
      sut.positionTapped(Position.topLeft);
      verifyNever(mockGame.changePlayer());
    });

    test(
        'game service does not change players after a turn that ends in a draw',
        () {
      sut.setup(mockGame, mockStreamController);
      final mockTurn = MockTurn();
      when(mockGame.turns).thenReturn([mockTurn]);
      when(mockGame.addTurnForPosition(any)).thenReturn(mockTurn);
      when(mockTurn.draw).thenReturn(true);
      when(mockTurn.win).thenReturn(false);
      sut.positionTapped(Position.topLeft);
      verifyNever(mockGame.changePlayer());
    });

    test('game service stops the game and closes the history on stop', () {
      sut.setup(mockGame, mockStreamController);
      sut.stop();
      verify(mockGame.stop());
      verify(mockStreamController.close());
    });

    test('game service requests correct shape from the game', () {
      sut.setup(mockGame, mockStreamController);
      sut.shapeForPosition(Position.topCenter);
      verify(mockGame.shapeForPosition(Position.topCenter));
    });
  });
}
