import 'package:flutter/material.dart';
import 'package:tictactoe/home/home_page.dart';
import 'package:tictactoe/game/game_service.dart';

void main() => runApp(TicTacToeApp(
      gameService: GameService(),
    ));

class TicTacToeApp extends StatelessWidget {
  final GameService gameService;

  const TicTacToeApp({Key key, this.gameService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
      theme: ThemeData(primaryColor: Color(0xFF613f8d)),
      home: HomePage(
        gameService: gameService,
      ),
    );
  }
}
