import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/game/game_space.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/circle.dart';
import 'package:tictactoe/game/shape/cross.dart';

import 'game_robot.dart';

import '../../test/mock.dart';

main() {
  testWidgets('tap shows correct shape', (WidgetTester tester) async {
    final robot = GameRobot();
    final mockGameService = MockGameService();
    robot.gameService = mockGameService;
    await tester.pumpWidget(MaterialApp(
      home: GameSpace(
        gameService: mockGameService,
      ),
    ));
    robot.tester = tester;
    await robot.tapPosition(Position.topLeft);
    robot.positionTapped(Position.topLeft);
  });

  testWidgets('correct shape is shown at the position',
      (WidgetTester tester) async {
    final robot = GameRobot();
    final mockGameService = MockGameService();
    robot.gameService = mockGameService;
    when(mockGameService.shapeForPosition(Position.topLeft))
        .thenReturn(Cross(0xFF3b94ec));
    when(mockGameService.shapeForPosition(Position.topRight))
        .thenReturn(Circle(0xFF3b94ec));
    await tester.pumpWidget(MaterialApp(
      home: GameSpace(
        gameService: mockGameService,
      ),
    ));
    robot.tester = tester;
    robot.hasCrossAtPosition(Position.topLeft);
    robot.hasCircleAtPosition(Position.topRight);
  });

  testWidgets('correct shape is shown after a tap',
      (WidgetTester tester) async {
    final robot = GameRobot();
    final gameService = GameService();
    final game = Game();
    game.addPlayer('Jairzinno');
    game.addPlayer('John');
    gameService.setup(game, StreamController());
    game.start();
    await tester.pumpWidget(MaterialApp(
      home: GameSpace(
        gameService: gameService,
      ),
    ));
    robot.tester = tester;
    await robot.tapPosition(Position.topLeft);
    robot.hasCrossAtPosition(Position.topLeft);
    await robot.tapPosition(Position.topRight);
    robot.hasCircleAtPosition(Position.topRight);
  });
}
