import 'package:flutter/material.dart';

class HomeOptions extends StatelessWidget {
  final VoidCallback onNewGame;
  final VoidCallback onHistory;

  const HomeOptions({Key key, this.onNewGame, this.onHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(child: Text('New Game'), onPressed: onNewGame),
          SizedBox(
            height: 12,
          ),
          RaisedButton(child: Text('History'), onPressed: onHistory),
        ],
      ),
    );
  }
}
