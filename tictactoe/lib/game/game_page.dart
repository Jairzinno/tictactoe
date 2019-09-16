import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/game_space.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/turn/turns_list.dart';
import 'package:tictactoe/turn/turns_page.dart';

class GamePage extends StatefulWidget {
  final GameService gameService;

  const GamePage({Key key, this.gameService}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Page(
      onMobileBuilder: (context, _, __) => _MobileGamePage(
        gameService: widget.gameService,
        positionTapped: (position) {
          widget.gameService.positionTapped(position);
        },
        onStop: () {
          onStopGame(context);
        },
        onTurns: () {
          onGoToTurns(context);
        },
      ),
      onTabletBuilder: (context, _, __) => _TabletGamePage(
        gameService: widget.gameService,
        positionTapped: (position) {
          widget.gameService.positionTapped(position);
        },
        onStop: () {
          onStopGame(context);
        },
      ),
      onWebBuilder: (context, _, __) => _WebGamePage(
        gameService: widget.gameService,
        positionTapped: (position) {
          widget.gameService.positionTapped(position);
        },
      ),
    );
  }

  void onStopGame(BuildContext context) {
    widget.gameService.stop();
    Navigator.of(context).pop();
  }

  void onGoToTurns(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return TurnsPage(gameService: widget.gameService);
    }));
  }
}

class _MobileGamePage extends StatelessWidget {
  final GameService gameService;
  final VoidCallback onStop;
  final VoidCallback onTurns;
  final ValueChanged<Position> positionTapped;

  const _MobileGamePage(
      {Key key,
      this.gameService,
      this.onStop,
      this.onTurns,
      this.positionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: ValueKey(gamePageAppBar),
        automaticallyImplyLeading: false,
        leading: IconButton(
          key: ValueKey(gamePageStopIconButton),
          icon: Icon(Icons.close),
          onPressed: onStop,
        ),
        title: Text('Game'),
        actions: <Widget>[
          IconButton(
            key: ValueKey(gamePageTurnsIconButton),
            icon: Icon(Icons.list),
            onPressed: onTurns,
          )
        ],
      ),
      body: Container(
        child: Center(
          child: GameSpace(
            gameService: gameService,
            onPositionTap: positionTapped,
          ),
        ),
      ),
    );
  }
}

class _TabletGamePage extends StatelessWidget {
  final GameService gameService;
  final VoidCallback onStop;
  final ValueChanged<Position> positionTapped;

  const _TabletGamePage(
      {Key key, this.gameService, this.onStop, this.positionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: ValueKey(gamePageAppBar),
        automaticallyImplyLeading: false,
        leading: IconButton(
          key: ValueKey(gamePageStopIconButton),
          icon: Icon(Icons.close),
          onPressed: onStop,
        ),
        title: Text('Game'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: GameSpace(
              gameService: gameService,
              onPositionTap: positionTapped,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TurnsList(
              turns: gameService.history,
            ),
          ),
        ],
      ),
    );
  }
}

class _WebGamePage extends StatelessWidget {
  final GameService gameService;
  final ValueChanged<Position> positionTapped;

  const _WebGamePage({Key key, this.gameService, this.positionTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: GameSpace(
              gameService: gameService,
              onPositionTap: positionTapped,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: TurnsList(
              turns: gameService.history,
            ),
          ),
        ],
      ),
    );
  }
}
