import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/model/turn.dart';
import 'package:tictactoe/service/game_service.dart';
import 'package:tictactoe/turn/turns_list.dart';

class TurnsPage extends StatelessWidget {
  final GameService gameService;

  const TurnsPage({Key key, @required this.gameService}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Page<List<Turn>>(
      onStream: (context) => gameService.history,
      onMobileBuilder: (context, _, stream) => _TurnsPage(
        turns: stream,
      ),
      onTabletBuilder: (context, _, stream) => _TurnsPage(
        turns: stream,
      ),
      onWebBuilder: (context, _, stream) => TurnsList(
        turns: stream,
      ),
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
