import 'package:flutter/material.dart';
import 'package:pathfinder_for_webspark/domain/models/point.dart';

class GridCell extends StatelessWidget {
  final Point point;
  final Color color;
  final double size;

  const GridCell({
    super.key,
    required this.point,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = color.computeLuminance() < 0.1
        ? Colors.white
        : Colors.black;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 0.5),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            point.toString(),
            style: TextStyle(color: textColor, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
