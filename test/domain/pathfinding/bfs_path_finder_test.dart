import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_for_webspark/domain/models/grid.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';
import 'package:pathfinder_for_webspark/domain/pathfinding/bfs_path_finder.dart';

void main() {
  group('BfsPathFinder Unit Tests', () {
    late BfsPathFinder pathFinder;

    setUp(() {
      pathFinder = BfsPathFinder();
    });

    test('Знаходить найкоротший шлях у 8 напрямках', () {
      final grid = Grid.fromRows(['.X.', '.X.', '...']);

      const start = Point(1, 2);
      const end = Point(2, 0);

      final path = pathFinder.findPath(grid, start, end);

      expect(path, isNotNull);
      expect(path, equals(const [Point(1, 2), Point(2, 1), Point(2, 0)]));
      expect(path!.first, equals(start));
      expect(path.last, equals(end));
    });

    test('Повертає [start], якщо початкова точка дорівнює кінцевій', () {
      final grid = Grid.fromRows(['...', '...', '...']);

      const point = Point(1, 1);
      final path = pathFinder.findPath(grid, point, point);

      expect(path, equals([point]));
    });

    test('Повертає null, якщо шляху не існує', () {
      final grid = Grid.fromRows(['...', '.XX', '.X.']);

      const start = Point(0, 0);
      const end = Point(2, 2); // Оточений 'X' з усіх боків

      final path = pathFinder.findPath(grid, start, end);

      expect(path, isNull);
    });

    test('Повертає null, якщо start або end є заблокованою клітинкою X', () {
      final grid = Grid.fromRows(['X..', '...', '..X']);

      // Старт на 'X'
      final path1 = pathFinder.findPath(
        grid,
        const Point(0, 0),
        const Point(1, 1),
      );
      // Фініш на 'X'
      final path2 = pathFinder.findPath(
        grid,
        const Point(1, 1),
        const Point(2, 2),
      );

      expect(path1, isNull);
      expect(path2, isNull);
    });

    test('Повертає null, якщо точки виходять за межі сітки', () {
      final grid = Grid.fromRows(['.X.', '.XX', 'X..']);

      final path = pathFinder.findPath(
        grid,
        const Point(-1, 0),
        const Point(5, 5),
      );

      expect(path, isNull);
    });
  });
}
