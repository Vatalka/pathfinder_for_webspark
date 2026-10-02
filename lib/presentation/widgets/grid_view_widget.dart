import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/core/constants/app_colors.dart';
import 'package:pathfinder_for_webspark/domain/models/grid.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';
import 'package:pathfinder_for_webspark/presentation/widgets/grid_cell.dart';

class GridViewWidget extends StatelessWidget {
  static const double _minCellSize = 36;

  final Grid grid;
  final Point start;
  final Point end;
  final List<Point> path;

  const GridViewWidget({
    super.key,
    required this.grid,
    required this.start,
    required this.end,
    required this.path,
  });

  Color _colorFor(Point p, Set<Point> pathCells) {
    if (p == start) return AppColors.start;
    if (p == end) return AppColors.end;
    if (grid.isBlocked(p)) return AppColors.blocked;
    if (pathCells.contains(p)) return AppColors.path;
    return AppColors.empty;
  }

  @override
  Widget build(BuildContext context) {
    final pathCells = path.toSet();

    return LayoutBuilder(
      builder: (context, constraints) {
        final fitByWidth = constraints.maxWidth / grid.size;
        final fitByHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight / grid.size
            : fitByWidth;
        final fitSize = fitByWidth < fitByHeight ? fitByWidth : fitByHeight;

        final needsScroll = fitSize < _minCellSize;
        final cellSize = needsScroll ? _minCellSize : fitSize;

        final cells = SizedBox(
          width: cellSize * grid.size,
          height: cellSize * grid.size,
          child: Column(
            children: [
              for (var y = 0; y < grid.size; y++)
                Row(
                  children: [
                    for (var x = 0; x < grid.size; x++)
                      GridCell(
                        point: Point(x, y),
                        color: _colorFor(Point(x, y), pathCells),
                        size: cellSize,
                      ),
                  ],
                ),
            ],
          ),
        );

        if (!needsScroll) return cells;

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.hasBoundedHeight
              ? constraints.maxHeight
              : constraints.maxWidth,
          child: InteractiveViewer(
            constrained: false,
            minScale: 0.3,
            maxScale: 3,
            child: cells,
          ),
        );
      },
    );
  }
}
