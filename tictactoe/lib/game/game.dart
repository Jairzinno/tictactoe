import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/game/shape/circle.dart';
import 'package:tictactoe/game/shape/cross.dart';
import 'package:tictactoe/game/shape/shape.dart';
import 'package:tictactoe/player/player.dart';
import 'package:tictactoe/turn/turn.dart';

class Game {
  Player _player1;
  Player _player2;
  final List<Turn> _turns = [];
  final Map<Position, Shape> _state = {};

  Player _currentPlayer;
  bool _gameEnded = false;

  Game();

  bool canPlay() => _player1 != null && _player2 != null;

  List<Turn> get turns => List<Turn>.unmodifiable(_turns);

  void addPlayer(String playerName) {
    if (_player1 == null) {
      _player1 = Player(playerName, Cross(0xFF3b94ec));
    } else if (_player2 == null) {
      _player2 = Player(playerName, Circle(0xFF65DDC7));
    }
  }

  void start() {
    _currentPlayer = _player1;
    _state.clear();
    _turns.clear();
  }

  Turn addTurnForPosition(Position position) {
    if (_gameEnded) {
      return null;
    }
    final turn = Turn(position, _currentPlayer);
    if (turn.isValid(_turns)) {
      _turns.add(turn);
      _state[position] = _currentPlayer.shape.copy();
      turn.win = _didPlayerWin();
      turn.draw = _didPlayerDraw();
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

  Shape shapeForPosition(Position position) => _state[position];

  bool _didPlayerWin() {
    return Position.winners.any((line) {
      final start = line.first;
      final center = line[1];
      final end = line.last;
      final win = _onlyCrosses(_currentPlayer.shape, _state[start],
              _state[center], _state[end]) ||
          _onlyCircles(
              _currentPlayer.shape, _state[start], _state[center], _state[end]);

      _state[start]?.highlight = win;
      _state[center]?.highlight = win;
      _state[end]?.highlight = win;
      _gameEnded = win;
      return win;
    });
  }

  bool _onlyCrosses(Shape player, Shape start, Shape center, Shape end) =>
      player is Cross && start is Cross && center is Cross && end is Cross;

  bool _onlyCircles(Shape player, Shape start, Shape center, Shape end) =>
      player is Circle && start is Circle && center is Circle && end is Circle;

  bool _didPlayerDraw() => !_didPlayerWin() && _state.length == 9;

  void stop() {
    _player1 = null;
    _player2 = null;
    _gameEnded = false;
    _state.clear();
    _turns.clear();
  }
}
