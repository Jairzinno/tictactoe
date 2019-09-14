import 'dart:async';

import 'package:tictactoe/model/game.dart';
import 'package:tictactoe/model/position.dart';
import 'package:tictactoe/model/shape/shape.dart';
import 'package:tictactoe/model/turn.dart';

class GameService {
  final Game game;
  final StreamController<List<Turn>> historyController;

  Stream<List<Turn>> get history => historyController.stream;

  GameService(this.game, this.historyController) {
    this.historyController.onListen = () {
      this.historyController.sink.add(game.turns);
    };
  }

  void addPlayer(String playerName) {
    game.addPlayer(playerName);
  }

  bool needPlayer() => !game.canPlay();

  void positionTapped(Position position) {
    final turn = game.addTurnForPosition(position);
    if (turn != null) {
      historyController.sink.add(game.turns);
    }
    if (game.didPlayerWin()) {
      print('we have a winner');
    } else {
      game.changePlayer();
    }
  }

  bool didPlayerWin() => game.didPlayerWin();

  void changePlayer() => game.changePlayer();

  void start() {
    game.start();
  }

  void stop() {
    game.stop();
    historyController.close();
  }

  Shape shapeForPosition(Position position) => game.state[position];
}
