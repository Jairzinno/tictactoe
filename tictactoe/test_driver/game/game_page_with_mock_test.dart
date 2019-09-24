import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

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
      if (await robot.isMobile) {
        await robot.tapStartButton();
        await robot.isShowingPlayerPage();
      }
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
        await robot.gameRequiresAnotherPlayer(true);
        await robot.tapSavePlayerNameButton();
        await robot.isShowingPlayerPage();
        await robot.enterPlayerName('John');
        await robot.gameRequiresAnotherPlayer(true);
        await robot.tapSavePlayerNameButton();
        await robot.isShowingGamePage();
      },
    );
  });
}
