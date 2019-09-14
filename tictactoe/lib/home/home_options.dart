import 'package:flutter/material.dart';
import 'package:tictactoe/core/value_keys.dart';

class HomeOptions extends StatelessWidget {
  final VoidCallback onNewGame;

  const HomeOptions({Key key, this.onNewGame}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        ConstrainedBox(
          constraints: BoxConstraints.expand(height: 80),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
                key: ValueKey(homePageStartNewGameRaisedButton),
                child: Text('New Game'),
                onPressed: onNewGame),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
