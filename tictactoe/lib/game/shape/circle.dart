import 'dart:ui';

import 'package:tictactoe/game/shape/shape.dart';

class Circle extends Shape {
  Circle(int color) : super(color);

  @override
  Path draw(double width) {
    Path path = Path();
    path.addOval(Rect.fromLTWH(10, 10, width - 20, width - 20));
    return path;
  }

  @override
  String toString() {
    return 'Circle';
  }

  @override
  Shape copy() {
    return Circle(color);
  }
}
