class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);

  Point operator +(Point other) => Point(x + other.x, y + other.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => '($x,$y)';
}
