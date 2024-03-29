import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/turn/turn.dart';
import 'package:tictactoe/turn/turns_list.dart';

class TurnsPage extends StatelessWidget {
  final GameService gameService;

  const TurnsPage({Key key, @required this.gameService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page<List<Turn>>(
      onStream: (context) => gameService.history,
      onMobileBuilder: (context, stream) => _TurnsPage(
        turns: stream,
      ),
      onTabletBuilder: (BuildContext context, Stream stream) => SizedBox(),
      onWebBuilder: (BuildContext context, Stream stream) => SizedBox(),
    );
  }
}

class _TurnsPage extends StatelessWidget {
  final Stream<List<Turn>> turns;

  const _TurnsPage({Key key, @required this.turns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Turns'),
        ),
        body: TurnsList(turns: turns));
  }
}
