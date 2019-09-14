import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/player/player_form.dart';

class PlayerPage extends StatelessWidget {
  final ValueChanged<String> onPlayerName;

  const PlayerPage({Key key, this.onPlayerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Player'),
      ),
      body: Page(
        onMobileBuilder: (BuildContext context, _, __) => Column(
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            PlayerForm(onPlayerName: onPlayerName),
            Spacer(
              flex: 1,
            ),
          ],
        ),
        onTabletBuilder: (BuildContext context, _, __) => Container(
          child: Row(
            children: <Widget>[
              Spacer(),
              Container(
                  width: 1000, child: PlayerForm(onPlayerName: onPlayerName)),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
