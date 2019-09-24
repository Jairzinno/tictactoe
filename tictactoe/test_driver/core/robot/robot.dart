import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:tictactoe/game/position.dart';

import '../device/device_type.dart';
import '../driver_handler_messages.dart';
import '../finder/finders.dart';
import '../matcher/matchers.dart';

class Robot {
  FlutterDriver _driver;

  set driver(FlutterDriver driver) {
    _driver = driver;
  }

  FlutterDriver get driver => _driver;

  Future<bool> get isMobile async {
    final _deviceType = await _currentDeviceType();
    return _deviceType == DeviceType.phone.toString();
  }

  Future<bool> get isTablet async {
    final _deviceType = await _currentDeviceType();
    return _deviceType == DeviceType.tablet.toString();
  }

  Future<String> _currentDeviceType() async {
    final _deviceType = await requestData(deviceType);
    return _deviceType;
  }

  Future<bool> resetWith(SerializableFinder finder) async {
    try {
      await _driver.getWidgetDiagnostics(finder, timeout: Duration(seconds: 1));
      expect(true, isTrue);
      return true;
    } catch (e) {
      print(
          'resetting because was expecting to find widget with finder ${finder.serialize()}.');
      return false;
    }
  }

  Future<bool> isVisible(SerializableFinder finder) async {
    try {
      await _driver.getWidgetDiagnostics(finder, timeout: Duration(seconds: 1));
      expect(true, isTrue);
      return true;
    } catch (e) {
      fail('expected to find widget with finder ${finder.serialize()}.');
    }
  }

  Future<void> tap(SerializableFinder finder) async {
    await _driver.tap(finder);
  }

  Future<void> enterText(String text, SerializableFinder finder) async {
    await _driver.enterText(text);
  }

  Future<String> getText(SerializableFinder finder) async {
    return await _driver.getText(finder);
  }

  Future<void> textfieldContainsText(
      SerializableFinder finder, String text) async {
    expect(await findTextField(finder, _driver), textFieldContains(text));
  }

  Future<void> textFieldContainsNoText(SerializableFinder finder) async {
    expect(await findTextField(finder, _driver), textFieldIsEmpty);
  }

  Future<void> shapeContainsColor(
      SerializableFinder finder, String color) async {
    expect(await findShape(finder, _driver), containsColor(color));
  }

  Future<void> shapeDoesNotContainColor(
      SerializableFinder finder, String color) async {
    expect(await findShape(finder, _driver), doesNotContainColor(color));
  }

  Future<String> requestData(String message) async {
    return await _driver.requestData(message);
  }

  Future<void> goBack() async {
    await _driver.tap(find.pageBack());
  }

  Future<void> findTurnAtIndex(SerializableFinder finder, int index,
      String position, String playerName, String shape) async {
    expect(await findListTiles(finder, _driver),
        containsTurnAtIndex(index, position, playerName, shape));
  }
}
