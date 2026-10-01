import 'package:flutter_test/flutter_test.dart';
import 'package:pathfinder_for_webspark/domain/models/grid.dart';

void main() {
  group('Grid Unit Tests', () {
    test('Викидає ArgumentError для порожньої сітки', () {
      expect(() => Grid.fromRows([]), throwsA(isA<ArgumentError>()));
    });

    test('Викидає ArgumentError для неквадратної сітки', () {
      expect(
        () => Grid.fromRows(['.X.', '...']),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Викидає ArgumentError, якщо рядки мають різну довжину', () {
      expect(
        () => Grid.fromRows(['.X.', '..', '...']),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'Викидає ArgumentError при недопустимих розмірах (<= 1 та >= 100)',
      () {
        expect(() => Grid.fromRows(['.']), throwsA(isA<ArgumentError>()));
      },
    );
  });
}
