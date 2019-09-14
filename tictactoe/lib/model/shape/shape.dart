import 'package:flutter/painting.dart';

abstract class Shape {
  final int color;
  bool highlight = false;

  Shape(this.color);

  Path draw(double width);

  Shape copy();
}
