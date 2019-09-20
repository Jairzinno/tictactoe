import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:tictactoe/game/game.dart';
import 'package:tictactoe/game/game_service.dart';
import 'package:tictactoe/player/player.dart';
import 'package:tictactoe/turn/turn.dart';

class MockPlayer extends Mock implements Player {}

class MockGame extends Mock implements Game {}

class MockStreamController extends Mock
    implements StreamController<List<Turn>> {}

class MockStreamSink extends Mock implements StreamSink<List<Turn>> {}

class MockTurn extends Mock implements Turn {}

class MockGameService extends Mock implements GameService {}
