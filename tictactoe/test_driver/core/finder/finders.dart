import 'package:flutter_driver/flutter_driver.dart';

Future<Map<String, Object>> findTextField(
    SerializableFinder finder, FlutterDriver driver) async {
  return await driver.getWidgetDiagnostics(finder, subtreeDepth: 50);
}

Future<Map<String, Object>> findShape(
    SerializableFinder finder, FlutterDriver driver) async {
  return await driver.getWidgetDiagnostics(finder, subtreeDepth: 50);
}

Future<Map<String, Object>> findListTiles(
    SerializableFinder finder, FlutterDriver driver) async {
  return await driver.getWidgetDiagnostics(finder, subtreeDepth: 50);
}
