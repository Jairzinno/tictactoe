import 'package:mockito/mockito.dart';
import 'package:tictactoe/game/game_service.dart';

import 'device/device_detection_service.dart';
import 'driver_handler_messages.dart';

class DriverHandler {
  final GameService gameService;

  DriverHandler({this.gameService});

  Future<String> dataHandler(String msg) async {
    switch (msg) {
      case deviceType:
        return DeviceDetectionService.instance().deviceType.toString();
        break;
      case anotherPlayerRequiredIsTrue:
        when(gameService?.needPlayer()).thenReturn(true);
        break;
      case anotherPlayerRequiredIsFalse:
        when(gameService?.needPlayer()).thenReturn(false);
        break;
    }
    return '';
  }
}
