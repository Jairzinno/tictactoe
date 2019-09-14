import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/game/game_page.dart';
import 'package:tictactoe/home/home_options.dart';
import 'package:tictactoe/player/player_page.dart';
import 'package:tictactoe/service/game_service.dart';

class HomePage extends StatelessWidget {
  final GameService gameService;

  const HomePage({Key key, @required this.gameService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page(
      onMobileBuilder: (context, _, __) => Scaffold(
        appBar: AppBar(
          title: Text('TicTacToe'),
        ),
        body: Column(
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            HomeOptions(
              onNewGame: () {
                onNewGame(context);
              },
              onHistory: onHistory,
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      onTabletBuilder: (context, _, __) => Scaffold(
        appBar: AppBar(
          title: Text('TicTacToe'),
        ),
        body: Row(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Container(
              width: 1000,
              child: Column(
                children: <Widget>[
                  Spacer(
                    flex: 2,
                  ),
                  HomeOptions(
                    onNewGame: () {
                      onNewGame(context);
                    },
                    onHistory: onHistory,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      onWebBuilder: (context, data, __) => Row(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          Container(
            width: 500,
            child: Column(
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                HomeOptions(
                  onNewGame: () {
                    onNewGame(context);
                  },
                  onHistory: onHistory,
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  void onNewGame(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PlayerPage(
        onPlayerName: (playerName) {
          onPlayerName(context, playerName);
        },
      );
    }));
  }

  void onPlayerName(BuildContext context, String playerName) {
    gameService.addPlayer(playerName);
    if (gameService.needPlayer()) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return PlayerPage(
          onPlayerName: (playerName) {
            onPlayerName(context, playerName);
          },
        );
      }));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        gameService.start();
        return GamePage(
          gameService: gameService,
        );
      }));
    }
  }

  void onHistory() {}
}
