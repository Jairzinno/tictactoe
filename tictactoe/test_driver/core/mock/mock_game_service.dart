import 'package:mockito/mockito.dart';
import 'package:tictactoe/game/game_service.dart';

class MockGameService extends Mock implements GameService {
  static MockGameService _instance;

  MockGameService._();

  factory MockGameService.instance() {
    if (_instance == null) {
      _instance = MockGameService._();
    }
    return _instance;
  }
}
