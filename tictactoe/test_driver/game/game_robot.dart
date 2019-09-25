import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/position.dart';

import '../core/driver_handler_messages.dart';
import '../core/robot/robot.dart';

class GameRobot extends Robot {
  Future<void> tapStartButton() async {
    final finder = find.byValueKey(homePageStartNewGameRaisedButton);
    await isVisible(finder);
    await tap(finder);
  }

  Future<void> reset() async {
    while (!await resetWith(find.byValueKey(homePageAppBar))) {
      await goBack();
    }
  }

  Future<bool> isShowingHomePage() async {
    return await isVisible(find.byValueKey(homePageAppBar));
  }

  Future<bool> isShowingPlayerPage() async {
    return await isVisible(find.byValueKey(playerPageAppBar));
  }

  Future<bool> isShowingGamePage() async {
    return await isVisible(find.byValueKey(gamePageAppBar));
  }

  Future<void> enterPlayerName(String name) async {
    final finder = find.byValueKey(playerPagePlayerNameTextFormField);
    await isVisible(finder);
    await tap(finder);
    await enterText(name, finder);
  }

  Future<void> gameRequiresAnotherPlayer(bool playerRequired) async {
    await requestData(playerRequired
        ? anotherPlayerRequiredIsTrue
        : anotherPlayerRequiredIsFalse);
  }

  Future<void> tapSavePlayerNameButton() async {
    final finder = find.byValueKey(playerPageSavePlayerRaisedButton);
    await isVisible(finder);
    await tap(finder);
  }

  Future<void> requiredPlayerNameIsShown() async {
    await textfieldContainsText(
        find.byValueKey(playerPagePlayerNameTextFormField),
        'Player name is required');
  }

  Future<void> tapStopGame() async {
    final finder = find.byValueKey(gamePageStopIconButton);
    await isVisible(finder);
    await tap(finder);
  }

  Future<void> tapPosition(Position position) async {
    final finder = find.byValueKey(_positionToValueKey(position));
    await isVisible(finder);
    await tap(finder);
  }

  String _positionToValueKey(Position position) {
    switch (position) {
      case Position.topLeft:
        return gamePageTopLeftShapeSpace;
      case Position.topCenter:
        return gamePageTopCenterShapeSpace;
      case Position.topRight:
        return gamePageTopRightShapeSpace;
      case Position.centerLeft:
        return gamePageCenterLeftShapeSpace;
      case Position.center:
        return gamePageCenterShapeSpace;
      case Position.centerRight:
        return gamePageCenterRightShapeSpace;
      case Position.bottomLeft:
        return gamePageBottomLeftShapeSpace;
      case Position.bottomCenter:
        return gamePageBottomCenterShapeSpace;
      case Position.bottomRight:
        return gamePageBottomRightShapeSpace;
      default:
        return gamePageCenterShapeSpace;
    }
  }

  Future<void> tapToTurns() async {
    final finder = find.byValueKey(gamePageTurnsIconButton);
    await isVisible(finder);
    await tap(finder);
  }

  Future<void> hasCrossAtPosition(Position position) async {
    final valueKey = _positionToValueKey(position);
    final finder = find.descendant(
        of: find.byValueKey(valueKey), matching: find.byType('CrossSpace'));
    await isVisible(finder);
  }

  Future<void> hasCircleAtPosition(Position position) async {
    final valueKey = _positionToValueKey(position);
    final finder = find.descendant(
        of: find.byValueKey(valueKey), matching: find.byType('CircleSpace'));
    await isVisible(finder);
  }

  Future<void> isBlankAtPosition(Position position) async {
    bool isMissingCircle = false;
    bool isMissingCross = false;
    try {
      await hasCrossAtPosition(position);
    } catch (e) {
      isMissingCross = true;
    }
    try {
      await hasCircleAtPosition(position);
    } catch (e) {
      isMissingCircle = true;
    }
    expect(isMissingCircle && isMissingCross, isTrue);
  }

  Future<void> hasWinningHighlightAtPosition(Position position) async {
    final valueKey = _positionToValueKey(position);
    final finder = find.byValueKey(valueKey);
    await shapeContainsColor(finder, '0xff404040');
  }

  Future<void> listTilesInList(
      int index, Position position, String playerName, String shape) async {
    final finder = find.byValueKey(gamePageTurnsListView);

    await findTurnAtIndex(
        finder, index, position.toString(), playerName, shape);
  }
}
