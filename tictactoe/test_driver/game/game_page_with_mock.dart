import 'package:flutter_driver/driver_extension.dart';
import 'package:tictactoe/home/home_page.dart';

import '../core/device/device_detector.dart';
import '../core/driver_handler.dart';
import '../core/mock/mock_game_service.dart';
import '../main_mock.dart' as app;

main() {
  final mockGameService = MockGameService.instance();
  final driverHandler = DriverHandler(gameService: mockGameService);
  enableFlutterDriverExtension(handler: driverHandler.dataHandler);
  app.main(
      home: DeviceDetector(
    child: HomePage(
      gameService: mockGameService,
    ),
  ));
}
