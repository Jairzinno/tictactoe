import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/game/game_space.dart';
import 'package:tictactoe/service/game_service.dart';
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
      onMobileBuilder: (context, _, __) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              widget.gameService.stop();
              Navigator.of(context).pop();
            },
          ),
          title: Text('Game'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TurnsPage(gameService: widget.gameService);
                }));
              },
            )
          ],
        ),
        body: Container(
          child: Center(
            child: GameSpace(
              gameService: widget.gameService,
              onPositionTap: (position) {
                widget.gameService.positionTapped(position);
              },
            ),
          ),
        ),
      ),
      onTabletBuilder: (context, _, __) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              widget.gameService.stop();
              Navigator.of(context).pop();
            },
          ),
          title: Text('Game'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: GameSpace(
                gameService: widget.gameService,
                onPositionTap: (position) {
                  widget.gameService.positionTapped(position);
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: TurnsList(
                turns: widget.gameService.history,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
