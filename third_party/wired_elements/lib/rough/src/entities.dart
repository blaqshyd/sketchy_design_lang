import 'dart:math';

import 'config.dart';
import 'core.dart';
import 'geometry.dart';

class Drawable {
  Drawable({this.shape, this.options, this.sets});
  String? shape;
  DrawConfig? options;
  List<OpSet>? sets;
}

class PointD extends Point<double> {
  PointD(double x, double y) : super(x, y);

  bool isInPolygon(List<PointD> points) {
    final vertices = points.length;

    // There must be at least 3 vertices in polygon
    if (vertices < 3) {
      return false;
    }
    final extreme = PointD(double.maxFinite, y);
    var count = 0;
    for (var i = 0; i < vertices; i++) {
      final current = points[i];
      final next = points[(i + 1) % vertices];
      if (Line(current, next).intersects(Line(this, extreme))) {
        if (getOrientation(current, this, next) ==
            PointsOrientation.collinear) {
          return Line(current, next).onSegment(this);
        }
        count++;
      }
    }
    // true if count is off
    return count.isOdd;
  }

  @override
  String toString() => 'PointD{x:$x, y:$y}';
}
