import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:tictactoe/game/position.dart';

import 'game_robot.dart';

main() {
  group('setup tests', () {
    GameRobot robot;
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      robot = GameRobot();
      robot.driver = driver;
    });

    tearDown(() async {
      await robot.reset();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('game starts with asking the first player\'s name', () async {
      await robot.tapStartButton();
      await robot.isShowingPlayerPage();
    });

    test('game does not continue without a player\'s name', () async {
      await robot.tapStartButton();
      await robot.tapSavePlayerNameButton();
      await robot.requiredPlayerNameIsShown();
    });

    test(
      'game keeps asking for a player name for the setup',
      () async {
        await robot.tapStartButton();
        await robot.enterPlayerName('Jairzinno');
        await robot.tapSavePlayerNameButton();
        await robot.isShowingPlayerPage();
        await robot.enterPlayerName('John');
        await robot.tapSavePlayerNameButton();
        await robot.isShowingGamePage();
        await robot.tapStopGame();
      },
    );
  });

  group('game tests', () {
    GameRobot robot;
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      robot = GameRobot();
      robot.driver = driver;
    });

    setUp(() async {
      await robot.tapStartButton();
      await robot.enterPlayerName('Jairzinno');
      await robot.tapSavePlayerNameButton();
      await robot.isShowingPlayerPage();
      await robot.enterPlayerName('John');
      await robot.tapSavePlayerNameButton();
      await robot.isShowingGamePage();
    });

    tearDown(() async {
      await robot.tapStopGame();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('game shows correct shape after a tap', () async {
      await robot.tapPosition(Position.topLeft);
      await robot.hasCrossAtPosition(Position.topLeft);
    });

    test('game alternates between shapes', () async {
      await robot.tapPosition(Position.topLeft);
      await robot.tapPosition(Position.topRight);
      await robot.tapPosition(Position.center);
      await robot.tapPosition(Position.centerLeft);
      await robot.tapPosition(Position.centerRight);
      await robot.hasCrossAtPosition(Position.topLeft);
      await robot.hasCircleAtPosition(Position.topRight);
      await robot.hasCrossAtPosition(Position.center);
      await robot.hasCircleAtPosition(Position.centerLeft);
      await robot.hasCrossAtPosition(Position.centerRight);
    });

    test('game highlights a win', () async {
      await robot.tapPosition(Position.topRight);
      await robot.tapPosition(Position.topLeft);
      await robot.tapPosition(Position.center);
      await robot.tapPosition(Position.bottomRight);
      await robot.tapPosition(Position.bottomLeft);
      await robot.hasCrossAtPosition(Position.topRight);
      await robot.hasCircleAtPosition(Position.topLeft);
      await robot.hasCrossAtPosition(Position.center);
      await robot.hasCircleAtPosition(Position.bottomRight);
      await robot.hasCrossAtPosition(Position.bottomLeft);
      await robot.hasWinningHighlightAtPosition(Position.topRight);
      await robot.hasWinningHighlightAtPosition(Position.center);
      await robot.hasWinningHighlightAtPosition(Position.bottomLeft);
    });

    test('game does not add shapes after a win', () async {
      await robot.tapPosition(Position.topRight);
      await robot.tapPosition(Position.topLeft);
      await robot.tapPosition(Position.center);
      await robot.tapPosition(Position.bottomRight);
      await robot.tapPosition(Position.bottomLeft);

      await robot.tapPosition(Position.centerLeft);
      await robot.isBlankAtPosition(Position.centerLeft);
    });

    test('game shows the history of turns in a list', () async {
      await robot.tapPosition(Position.topLeft);
      await robot.tapPosition(Position.topRight);
      await robot.tapPosition(Position.center);
      await robot.tapPosition(Position.centerLeft);
      await robot.tapPosition(Position.centerRight);
      if (await robot.isMobile) {
        robot.tapToTurns();
      }
      await robot.hasTurnAtIndex(
          0, Position.topLeft, 'Jairzinno', 'CrossSpace');
      if (await robot.isMobile) {
        await robot.goBack();
      }
    }, timeout: Timeout(Duration(minutes: 1)));
  });
}
