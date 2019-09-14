import 'package:flutter/material.dart';
import 'package:tictactoe/game/shape_space.dart';
import 'package:tictactoe/model/turn.dart';

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
                trailing: ShapeSpace(
                  width: 60,
                  shape: turn.player.shape,
                ),
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
}
