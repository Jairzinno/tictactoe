import 'dart:async';

import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/shape.dart';
import 'package:tictactoe/turn/turn.dart';

class GameService {
  Game _game;

  StreamController<List<Turn>> _historyController;

  Stream<List<Turn>> get history => _historyController.stream;

  void setup(Game game, StreamController<List<Turn>> historyController) {
    _game = game;
    _historyController = historyController;
    _historyController.onListen = () {
      _historyController.sink.add(_game.turns);
    };
  }

  bool needPlayer() => !_game.canPlay();

  void addPlayer(String playerName) {
    _game.addPlayer(playerName);
  }

  void start() {
    _game.start();
  }

  void stop() {
    _game.stop();
    _historyController.close();
  }

  void positionTapped(Position position) {
    final turn = _game.addTurnForPosition(position);
    if (turn != null) {
      _historyController.sink.add(_game.turns);
      if (!turn.win && !turn.draw) {
        _game.changePlayer();
      }
    }
  }

  Shape shapeForPosition(Position position) => _game.shapeForPosition(position);
}
