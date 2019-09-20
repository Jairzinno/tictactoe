import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class RichTextFinder extends MatchFinder {
  RichTextFinder(this.text, {bool skipOffstage = true})
      : super(skipOffstage: skipOffstage);

  final String text;

  @override
  String get description => 'text "$text"';

  @override
  bool matches(Element candidate) {
    if (candidate.widget is RichText) {
      final RichText textWidget = candidate.widget;
      return textWidget.text.toPlainText() == text;
    }
    return false;
  }
}
