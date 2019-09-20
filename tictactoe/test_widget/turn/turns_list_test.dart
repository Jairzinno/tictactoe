import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/circle.dart';
import 'package:tictactoe/game/shape/cross.dart';
import 'package:tictactoe/player/player.dart';
import 'package:tictactoe/turn/turn.dart';
import 'package:tictactoe/turn/turns_list.dart';
import 'package:tictactoe/game/shape_space.dart';
import 'turn_robot.dart';

main() {
  testWidgets('turns list shows entries after played turns', (tester) async {
    final robot = TurnRobot(StreamController());
    await tester.pumpWidget(MaterialApp(
      home: Container(color: Colors.red, child: TurnsList(turns: robot.turns)),
    ));
    robot.tester = tester;
    await robot.addTurn(
      Turn(Position.topLeft, Player('Jairzinno', Cross(0xFFFF0000))),
    );
    robot.findListTileForTurn(
        CrossSpace, 'Played the top left position', 'Jairzinno');
    await robot.addTurn(
      Turn(Position.topRight, Player('John', Circle(0xFF00FF00))),
    );
    robot.findListTileForTurn(
        CircleSpace, 'Played the top right position', 'John');
  });
}
