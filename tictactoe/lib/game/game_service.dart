import 'dart:async';

import 'package:tictactoe/model/game.dart';
import 'package:tictactoe/model/position.dart';
import 'package:tictactoe/model/shape/shape.dart';
import 'package:tictactoe/model/turn.dart';

class GameService {
  Game _game;
  StreamController<List<Turn>> _historyController;

  Stream<List<Turn>> get history => _historyController.stream;

  void addPlayer(String playerName) {
    _game.addPlayer(playerName);
  }

  bool needPlayer() => !_game.canPlay();

  void setup(Game game, StreamController<List<Turn>> historyController) {
    _game = game;
    _historyController = historyController;
    _historyController.onListen = () {
      _historyController.sink.add(_game.turns);
    };
  }

  void start() {
    _game.start();
  }

  void positionTapped(Position position) {
    final turn = _game.addTurnForPosition(position);
    if (turn != null) {
      _historyController.sink.add(_game.turns);
      if (!turn.win) {
        _game.changePlayer();
      }
    }
  }

  void stop() {
    _game.stop();
    _historyController.close();
  }

  Shape shapeForPosition(Position position) => _game.state[position];
}
