import 'package:test/test.dart';
import 'package:tictactoe/game/position.dart';
import 'package:tictactoe/turn/turn.dart';

import '../mock.dart';

main() {
  group('turn tests', () {
    final mockPlayer = MockPlayer();
    test('a turn is valid when the previous turns passed is null', () {
      final turn = Turn(Position.bottomCenter, mockPlayer);
      expect(turn.isValid(null), isTrue);
    });

    test('a turn is valid when the previous turns passed is empty', () {
      final turn = Turn(Position.bottomCenter, mockPlayer);
      expect(turn.isValid([]), isTrue);
    });

    test(
        'a turn is valid when the previous turns don\'t contain the current position',
        () {
      final turn = Turn(Position.bottomCenter, mockPlayer);
      final previousTurns = <Turn>[
        Turn(Position.topLeft, mockPlayer),
        Turn(Position.topCenter, mockPlayer),
        Turn(Position.topRight, mockPlayer),
        Turn(Position.centerLeft, mockPlayer),
        Turn(Position.center, mockPlayer),
        Turn(Position.centerRight, mockPlayer),
        Turn(Position.bottomLeft, mockPlayer),
        Turn(Position.bottomRight, mockPlayer),
      ];
      expect(turn.isValid(previousTurns), isTrue);
    });

    test(
        'a turn is not valid when the previous turns contain the current position',
        () {
      final turn = Turn(Position.bottomCenter, mockPlayer);
      final previousTurns = <Turn>[
        Turn(Position.topLeft, mockPlayer),
        Turn(Position.topCenter, mockPlayer),
        Turn(Position.topRight, mockPlayer),
        Turn(Position.centerLeft, mockPlayer),
        Turn(Position.center, mockPlayer),
        Turn(Position.centerRight, mockPlayer),
        Turn(Position.bottomLeft, mockPlayer),
        Turn(Position.bottomCenter, mockPlayer),
        Turn(Position.bottomRight, mockPlayer),
      ];
      expect(turn.isValid(previousTurns), isFalse);
    });
  });
}
