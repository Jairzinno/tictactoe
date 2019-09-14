import 'dart:ui';

import 'package:tictactoe/model/shape/shape.dart';

class Square extends Shape {
  Square(int color) : super(color);

  @override
  Path draw(double width) {
    // TODO: implement draw
    return null;
  }

  @override
  Shape copy() {
    return Square(color);
  }
}
