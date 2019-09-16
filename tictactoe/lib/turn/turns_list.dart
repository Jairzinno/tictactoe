import 'package:flutter/material.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/game/shape_space.dart';
import 'package:tictactoe/turn/turn.dart';

class TurnsList extends StatelessWidget {
  final Stream<List<Turn>> turns;

  const TurnsList({Key key, @required this.turns}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Turn>>(
      stream: turns,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active &&
            snapshot.hasData) {
          return ListView.builder(
            key: ValueKey(gamePageTurnsListView),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final turn = snapshot.data[index];
              return ListTile(
                title: Text(turn.player.name),
                subtitle: RichText(
                    text: TextSpan(
                        text: 'Played the',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                        children: [
                      TextSpan(
                          text: ' ${turn.position}',
                          style: TextStyle(
                              color: Theme.of(context).textTheme.button.color,
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: ' position')
                    ])),
                leading: ShapeSpace(
                  width: 60,
                  shape: turn.player.shape,
                ),
                trailing: _trailing(turn),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _trailing(Turn turn) {
    if (turn.win) {
      return Icon(Icons.assistant_photo);
    }
    if (turn.draw) {
      return Icon(Icons.pause);
    }
    return null;
  }
}
