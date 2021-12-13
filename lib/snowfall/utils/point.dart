import 'dart:math' as math;

class Point {
  double x = 0;
  double y = 0;

  Point([this.x = 0, this.y = 0]);

  Point add(Point p) {
    return Point(x + p.x, y + p.y);
  }

  Point clone() {
    return Point(x, y);
  }

  double degreesTo(Point p) {
    double dx = x = p.x;
    double dy = y = p.y;
    double angle = math.atan2(dy, dx); // radians
    return angle * (180 / math.pi); // degrees
  }

  double _distance(Point p) {
    double x = this.x - p.x;
    double y = this.y - p.y;
    return math.sqrt(x * x + y * y);
  }

  bool equals(Point p) {
    return x == p.x && y == p.y;
  }

  /// find point between points
  Point _interpolate(Point p, double f) {
    return Point(p.x + (x - p.x) * f, p.y + (y - p.y) * f);
  }

  double length() {
    return math.sqrt(x * x + y * y);
  }

  void normalize(double thickness) {
    double l = length();
    x = x / l * thickness;
    y = y / l * thickness;
  }

  void orbit(Point origin, double arcWidth, double arcHeight, double degrees) {
    double radians = degrees * (math.pi / 180);
    x = origin.x + arcWidth * math.cos(radians);
    y = origin.y + arcHeight * math.sin(radians);
  }

  void offset(double dx, double dy) {
    x += dx;
    y += dy;
  }

  Point subtract(Point p) {
    return Point(x - p.x, y - p.y);
  }

  @override
  String toString() {
    return '(x=$x, y=$y)';
  }

  static Point pointsInterpolation(Point p1, Point p2, double f) {
    return p1._interpolate(p2, f);
  }

  static Point polar(double l, double r) {
    return Point(l * math.cos(r), l * math.sin(r));
  }

  static double distance(Point p1, Point p2) {
    return p1._distance(p2);
  }

  Point operator +(Point p) => Point(x + p.x, y + p.y);

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;

  @override
  int get hashCode => x.hashCode + y.hashCode;
}
