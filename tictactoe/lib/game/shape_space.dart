import 'package:flutter/material.dart';
import 'package:tictactoe/game/shape/shape.dart';

class ShapeSpace extends StatelessWidget {
  final double width;
  final Shape shape;
  final VoidCallback onTap;

  const ShapeSpace({Key key, this.width, this.shape, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shape == null) {
      return InkWell(
        child: Container(
          width: width,
          height: width,
        ),
        onTap: onTap,
      );
    } else {
      return InkWell(
        child: Container(
          color: shape.highlight ? Color(0xFF404040) : null,
          width: width,
          height: width,
          child: CustomPaint(
            painter: ShapePainter(shape),
          ),
        ),
        onTap: onTap,
      );
    }
  }
}

class ShapePainter extends CustomPainter {
  final Shape shape;

  ShapePainter(this.shape);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(shape.color)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Path path = shape.draw(size.width);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
