import 'package:flutter/material.dart';
import 'package:tictactoe/core/value_keys.dart';

class PlayerForm extends StatefulWidget {
  final ValueChanged<String> onPlayerName;

  const PlayerForm({Key key, this.onPlayerName}) : super(key: key);
  @override
  _PlayerFormState createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: ValueKey(playerPagePlayerNameTextFormField),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Name'),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Player name is required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    widget.onPlayerName(value);
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                RaisedButton(
                  key: ValueKey(playerPageSavePlayerRaisedButton),
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }
                  },
                )
              ],
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
