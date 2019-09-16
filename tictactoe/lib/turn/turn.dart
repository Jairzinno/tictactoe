import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/player/player.dart';

class Turn {
  final Position position;
  final Player player;
  bool win = false;
  bool draw = false;

  Turn(this.position, this.player);

  bool isValid(List<Turn> previousTurns) {
    return previousTurns == null ||
        !previousTurns.any((previousTurn) => previousTurn.position == position);
  }

  @override
  String toString() {
    return '${player.name}-$position:${player.shape}, win: $win, draw: $draw';
  }
}
