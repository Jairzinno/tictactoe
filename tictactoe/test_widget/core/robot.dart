import 'package:flutter_test/flutter_test.dart';

class Robot {
  WidgetTester _tester;

  set tester(WidgetTester tester) {
    _tester = tester;
  }

  Future<void> pump() async {
    await _tester.pump();
  }

  Future<void> waitForAnimations([
    Duration duration = const Duration(milliseconds: 100),
    EnginePhase phase = EnginePhase.sendSemanticsUpdate,
    Duration timeout = const Duration(minutes: 10),
  ]) async {
    await _tester.pumpAndSettle(duration, phase, timeout);
  }

  Future<void> findWidgetWithText(Type widgetType, String text) async {
    find.widgetWithText(widgetType, text);
  }

  Future<void> findWidgetByType(Type widgetType) async {
    expect(find.byType(widgetType), findsOneWidget);
  }

  Future<void> tap(Finder finder) async {
    await _tester.tap(finder);
    await _tester.pump();
  }

  Future<void> enterText(String text, Finder finder) async {
    await _tester.enterText(finder, text);
    await _tester.pump();
  }
}
