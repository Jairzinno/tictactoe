import 'dart:ui';

import 'package:tictactoe/model/shape/shape.dart';

class Cross extends Shape {
  Cross(int color) : super(color);

  @override
  Path draw(double width) {
    Path path = Path();
    path.moveTo(10, 10);
    path.lineTo(width - 10, width - 10);
    path.moveTo(10, width - 10);
    path.lineTo(width - 10, 10);
    return path;
  }

  @override
  String toString() {
    return 'Cross';
  }

  @override
  Shape copy() {
    return Cross(color);
  }
}
