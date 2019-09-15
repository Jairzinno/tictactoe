import 'package:flutter/material.dart';
import 'package:tictactoe/core/page.dart';
import 'package:tictactoe/core/value_keys.dart';
import 'package:tictactoe/player/player_form.dart';

class PlayerPage extends StatelessWidget {
  final ValueChanged<String> onPlayerName;

  const PlayerPage({Key key, this.onPlayerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page(
        onMobileBuilder: (BuildContext context, _, __) => _DevicePlayerPage(
              body: PlayerForm(onPlayerName: onPlayerName),
            ),
        onTabletBuilder: (BuildContext context, _, __) => _DevicePlayerPage(
              body: Row(
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(Size(
                        MediaQuery.of(context).size.width / 3,
                        MediaQuery.of(context).size.height)),
                    child: PlayerForm(onPlayerName: onPlayerName),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
        onWebBuilder: (BuildContext context, _, __) =>
            _WebPlayerPage(onPlayerName: onPlayerName));
  }
}

class _DevicePlayerPage extends StatelessWidget {
  final Widget body;

  const _DevicePlayerPage({Key key, @required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: ValueKey(playerPageAppBar),
        title: Text('Add a Player'),
      ),
      body: body,
    );
  }
}

class _WebPlayerPage extends StatelessWidget {
  final ValueChanged<String> onPlayerName;

  const _WebPlayerPage({Key key, @required this.onPlayerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 1,
          ),
          ConstrainedBox(
            constraints: BoxConstraints.loose(Size(
                MediaQuery.of(context).size.width / 4,
                MediaQuery.of(context).size.height)),
            child: PlayerForm(onPlayerName: onPlayerName),
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
