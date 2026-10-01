import 'package:pathfinder_for_webspark/domain/models/point.dart';

enum CellType { empty, blocked }

class Grid {
  final List<List<CellType>> _cells;

  Grid._(this._cells);

  factory Grid.fromRows(List<String> rows) {
    if (rows.isEmpty) {
      throw ArgumentError('Сітка не може бути порожньою');
    }

    final size = rows.first.length;
    if (size <= 1 || size >= 100 || rows.length <= 1 || rows.length >= 100) {
      throw ArgumentError('Довжина сітки має бути > 1 та < 100');
    }

    if (rows.length != size) {
      throw ArgumentError('Сітка має бути квадратною');
    }

    final cells = <List<CellType>>[];

    for (final row in rows) {
      if (row.length != size) {
        throw ArgumentError('Усі рядки сітки мають бути однакової довжини');
      }
      cells.add([
        for (final char in row.split(''))
          char.toUpperCase() == 'X' ? CellType.blocked : CellType.empty,
      ]);
    }
    return Grid._(cells);
  }

  int get size => _cells.length;

  CellType cellAt(Point p) => _cells[p.y][p.x];

  bool isInside(Point p) => p.x >= 0 && p.x < size && p.y >= 0 && p.y < size;

  bool isBlocked(Point p) => cellAt(p) == CellType.blocked;

  bool isWalkable(Point p) => isInside(p) && !isBlocked(p);
}
