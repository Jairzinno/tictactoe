import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/game_page.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/home/home_options.dart';
import 'package:tictactoe/player/player_page.dart';

class HomePage extends StatelessWidget {
  final GameService gameService;

  const HomePage({Key key, @required this.gameService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page(
      onMobileBuilder: (context, _) => _DeviceHomePage(
        body: HomeOptions(
          onNewGame: () {
            _onNewGame(context);
          },
        ),
      ),
      onTabletBuilder: (context, _) => _DeviceHomePage(
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
                  _onNewGame(context);
                },
              ),
            ),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
      onWebBuilder: (context, data) => _WebHomePage(
        onNewGame: () {
          _onNewGame(context);
        },
      ),
    );
  }

  void _onNewGame(BuildContext context) {
    gameService.setup(Game(), StreamController.broadcast());
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PlayerPage(
        onPlayerName: (playerName) {
          _onPlayerName(context, playerName);
        },
      );
    }));
  }

  void _onPlayerName(BuildContext context, String playerName) {
    gameService.addPlayer(playerName);
    if (gameService.needPlayer()) {
      _toPlayerPage(context);
    } else {
      _toGamePage(context);
    }
  }

  void _toPlayerPage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return PlayerPage(
        onPlayerName: (playerName) {
          _onPlayerName(context, playerName);
        },
      );
    }));
  }

  void _toGamePage(BuildContext context) {
    gameService.start();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return GamePage(
        gameService: gameService,
      );
    }));
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
