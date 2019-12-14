import 'package:flutter_driver/flutter_driver.dart';

Future<Map<String, Object>> findWidget(
    SerializableFinder finder, FlutterDriver driver) async {
  return await driver.getWidgetDiagnostics(finder, subtreeDepth: 50);
}
