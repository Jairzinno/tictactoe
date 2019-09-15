import 'package:flutter/material.dart';
import 'package:tictactoe/home/home_page.dart';
import 'package:tictactoe/service/game_service.dart';

void main() => runApp(MyApp(
      gameService: GameService(),
    ));

class MyApp extends StatelessWidget {
  final GameService gameService;

  const MyApp({Key key, this.gameService}) : super(key: key);
  // This widget is the root of your application.
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
