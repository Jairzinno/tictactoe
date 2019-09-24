import 'package:flutter_driver/driver_extension.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/home/home_page.dart';

import '../core/device/device_detector.dart';
import '../core/driver_handler.dart';
import '../main_mock.dart' as app;

main() {
  final driverHandler = DriverHandler();
  enableFlutterDriverExtension(handler: driverHandler.dataHandler);
  app.main(
      home: DeviceDetector(
    child: HomePage(
      gameService: GameService(),
    ),
  ));
}
