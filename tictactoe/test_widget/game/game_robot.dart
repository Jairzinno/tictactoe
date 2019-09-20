import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/cross.dart';
import 'package:tictactoe/game/shape_space.dart';

import '../core/robot.dart';
import '../../test/mock.dart';

class GameRobot extends Robot {
  MockGameService _gameService;

  set gameService(GameService gameService) => _gameService = gameService;

  Future<void> tapPosition(Position position) async {
    final valueKey = _positionToValueKey(position);
    expect(find.byKey(valueKey), findsOneWidget);
    final finder = find.byType(ShapeSpace);
    await tap(finder.first);
  }

  Future<void> positionTapped(Position position) async {
    verify(_gameService.positionTapped(position));
  }

  void hasCrossAtPosition(Position position) {
    final valueKey = _positionToValueKey(position);
    find.descendant(
        of: find.byKey(valueKey), matching: find.byType(CrossSpace));
  }

  void hasCircleAtPosition(Position position) {
    final valueKey = _positionToValueKey(position);
    find.descendant(
        of: find.byKey(valueKey), matching: find.byType(CircleSpace));
  }

  ValueKey _positionToValueKey(Position position) {
    switch (position) {
      case Position.topLeft:
        return const Key(gamePageTopLeftShapeSpace);
      case Position.topCenter:
        return const Key(gamePageTopCenterShapeSpace);
      case Position.topRight:
        return const Key(gamePageTopRightShapeSpace);
      case Position.centerLeft:
        return const Key(gamePageCenterLeftShapeSpace);
      case Position.center:
        return const Key(gamePageCenterShapeSpace);
      case Position.centerRight:
        return const Key(gamePageCenterRightShapeSpace);
      case Position.bottomLeft:
        return const Key(gamePageBottomLeftShapeSpace);
      case Position.bottomCenter:
        return const Key(gamePageBottomCenterShapeSpace);
      case Position.bottomRight:
        return const Key(gamePageBottomRightShapeSpace);
      default:
        return const Key(gamePageCenterShapeSpace);
    }
  }
}
