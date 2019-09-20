class Position {
  const Position(this.x, this.y)
      : assert(x != null),
        assert(y != null);

  final double x;
  final double y;

  String get name {
    String horizontal;
    String vertical;

    if (x == _left) {
      horizontal = 'left';
    } else if (x == _center) {
      horizontal = 'center';
    } else if (x == _right) {
      horizontal = 'right';
    }

    if (y == _top) {
      vertical = 'top';
    } else if (y == _center) {
      vertical = 'center';
    } else if (y == _bottom) {
      vertical = 'bottom';
    }
    if (horizontal == vertical) {
      return 'center';
    }
    return '$vertical $horizontal';
  }

  @override
  String toString() => name;

  static const double _left = -1.0;
  static const double _center = 0.0;
  static const double _right = 1.0;

  static const double _top = -1.0;
  static const double _bottom = 1.0;

  static const Position topLeft = const Position(_left, _top);

  static const Position topCenter = const Position(_center, _top);

  static const Position topRight = const Position(_right, _top);

  static const Position centerLeft = const Position(_left, _center);

  static const Position center = const Position(_center, _center);

  static const Position centerRight = const Position(_right, _center);

  static const Position bottomLeft = const Position(_left, _bottom);

  static const Position bottomCenter = const Position(_center, _bottom);

  static const Position bottomRight = const Position(_right, _bottom);

  static List<List<Position>> winners = [
    [topLeft, topCenter, topRight],
    [centerLeft, center, centerRight],
    [bottomLeft, bottomCenter, bottomRight],
    [topLeft, centerLeft, bottomLeft],
    [topCenter, center, bottomCenter],
    [topRight, centerRight, bottomRight],
    [topLeft, center, bottomRight],
    [topRight, center, bottomLeft],
  ];
}
