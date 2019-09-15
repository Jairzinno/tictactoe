import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/game_page.dart';
import 'package:tictactoe/home/home_options.dart';
import 'package:tictactoe/model/game.dart';
import 'package:tictactoe/player/player_page.dart';
import 'package:tictactoe/service/game_service.dart';

class HomePage extends StatelessWidget {
  final GameService gameService;

  const HomePage({Key key, @required this.gameService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page(
      onMobileBuilder: (context, _, __) => _DeviceHomePage(
        body: HomeOptions(
          onNewGame: () {
            onNewGame(context);
          },
        ),
      ),
      onTabletBuilder: (context, _, __) => _DeviceHomePage(
        body: Row(
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(
                  MediaQuery.of(context).size.width / 3,
                  MediaQuery.of(context).size.height)),
              child: HomeOptions(
                onNewGame: () {
                  onNewGame(context);
                },
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      onWebBuilder: (context, data, __) => _WebHomePage(
        onNewGame: () {
          onNewGame(context);
        },
      ),
    );
  }

  void onNewGame(BuildContext context) {
    gameService.setup(Game(), StreamController.broadcast());
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
      gameService.start();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return GamePage(
          gameService: gameService,
        );
      }));
    }
  }
}

class _DeviceHomePage extends StatelessWidget {
  final Widget body;

  const _DeviceHomePage({Key key, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: ValueKey(homePageAppBar),
        title: Text('TicTacToe'),
      ),
      body: body,
    );
  }
}

class _WebHomePage extends StatelessWidget {
  final VoidCallback onNewGame;

  const _WebHomePage({Key key, @required this.onNewGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.loose(Size(
              MediaQuery.of(context).size.width / 4,
              MediaQuery.of(context).size.height)),
          child: HomeOptions(onNewGame: onNewGame),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
