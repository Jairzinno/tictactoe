import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/circle.dart';
import 'package:tictactoe/game/shape/cross.dart';
import 'package:tictactoe/game/shape/shape.dart';
import 'package:tictactoe/player/player.dart';
import 'package:tictactoe/turn/turn.dart';

class Game {
  Player _player1;
  Player _player2;
  final List<Turn> turns = [];
  final Map<Position, Shape> state = {};

  Player _currentPlayer;
  bool _gameEnded = false;

  Game();

  bool canPlay() => _player1 != null && _player2 != null;

  void addPlayer(String playerName) {
    if (_player1 == null) {
      _player1 = Player(playerName, Cross(0xFF3b94ec));
    } else if (_player2 == null) {
      _player2 = Player(playerName, Circle(0xFF65DDC7));
    }
  }

  void start() {
    _currentPlayer = _player1;
    state.clear();
    turns.clear();
  }

  Turn addTurnForPosition(Position position) {
    if (_gameEnded) {
      return null;
    }
    final turn = Turn(position, _currentPlayer);
    if (turn.isValid(turns)) {
      turns.add(turn);
      state[position] = _currentPlayer.shape.copy();
      turn.win = didPlayerWin();
      turn.draw = didPlayerDraw();
      return turn;
    }
    return null;
  }

  void changePlayer() {
    if (_player1 == _currentPlayer) {
      _currentPlayer = _player2;
    } else {
      _currentPlayer = _player1;
    }
  }

  bool didPlayerWin() {
    return Position.winners.any((line) {
      final start = line.first;
      final center = line[1];
      final end = line.last;
      print('${state[start]}-${state[center]}-${state[end]}');

      final win =
          state[start].runtimeType == _currentPlayer.shape.runtimeType &&
              state[center].runtimeType == _currentPlayer.shape.runtimeType &&
              state[end].runtimeType == _currentPlayer.shape.runtimeType;
      if (win) {
        state[start].highlight = true;
        state[center].highlight = true;
        state[end].highlight = true;
        _gameEnded = true;
      }
      return win;
    });
  }

  bool didPlayerDraw() => !didPlayerWin() && state.length == 9;

  void stop() {
    _player1 = null;
    _player2 = null;
    _gameEnded = false;
    state.clear();
    turns.clear();
  }
}
