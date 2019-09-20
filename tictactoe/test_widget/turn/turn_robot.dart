import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/turn/turn.dart';

import '../core/finder.dart';
import '../core/robot.dart';

class TurnRobot extends Robot {
  final StreamController<List<Turn>> _streamController;
  final List<Turn> _turns = [];

  Stream<List<Turn>> get turns => _streamController.stream;

  TurnRobot(this._streamController);

  Future<void> addTurn(Turn turn) async {
    _turns.add(turn);
    _streamController.add(_turns);
    await pump();
  }

  void findListTileForTurn(
      Type shapeType, String positionText, String playerName) {
    expect(
        find.descendant(
            of: find.byType(ListTile), matching: find.byType(shapeType)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(ListTile), matching: RichTextFinder(positionText)),
        findsOneWidget);
    expect(
        find.descendant(
            of: find.byType(ListTile), matching: find.text(playerName)),
        findsOneWidget);
  }
}
