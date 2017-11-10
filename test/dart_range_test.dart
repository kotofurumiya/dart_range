import 'package:test/test.dart';
import 'package:dart_range/dart_range.dart';

void main() {
  group('Finite Range', () {
    test('range()', () {
      final generated = range(5, 10);

      final generatedInt = range<int>(5, 10);
      final generatedDouble = range<double>(5.0, 10.0);

      expect(generated, orderedEquals([5, 6, 7, 8, 9]));

      expect(generatedInt, orderedEquals([5, 6, 7, 8, 9]));
      expect(generatedDouble, orderedEquals([5.0, 6.0, 7.0, 8.0, 9.0]));
    });

    test('range() with a step', () {
      final generated1 = range(1, 6, 2);
      final generated2 = range(1, 7, 2);

      final generatedInt    = range<int>(1, 7, 2);
      final generatedDouble = range<double>(1.0, 7.0, 2.0);

      expect(generated1, orderedEquals([1, 3, 5]));
      expect(generated2, orderedEquals([1, 3, 5]));

      expect(generatedInt, orderedEquals([1, 3, 5]));
      expect(generatedDouble, orderedEquals([1.0, 3.0, 5.0]));
    });

    test('range() with a negative step', () {
      final generated1 = range(1, -6, -2);
      final generated2 = range(1, -7, -2);

      final generatedInt    = range<int>(1, -7, -2);
      final generatedDouble = range<double>(1.0, -7.0, -2.0);

      expect(generated1, orderedEquals([1, -1, -3, -5]));
      expect(generated2, orderedEquals([1, -1, -3, -5]));

      expect(generatedInt, orderedEquals([1, -1, -3, -5]));
      expect(generatedDouble, orderedEquals([1.0, -1.0, -3.0, -5.0]));
    });

    test('range() with a reverse step', () {
      final generated1 = range(-1, 5, -1);
      final generated2 = range(1, -5, 1);

      final generatedInt    = range<int>(1, -5, 1);
      final generatedDouble = range<double>(1.0, -5.0, 1.0);

      expect(generated1, isEmpty);
      expect(generated2, isEmpty);

      expect(generatedInt, isEmpty);
      expect(generatedDouble, isEmpty);
    });

    test('range() with 0 step', () {
      expect(() => range(1, 2, 0), throwsArgumentError);
    });

    test('inclusiveRange()', () {
      final generated = inclusiveRange(1, 3);

      final generatedInt    = inclusiveRange<int>(1, 3);
      final generatedDouble = inclusiveRange<double>(1.0, 3.0);

      expect(generated, orderedEquals([1, 2, 3]));

      expect(generatedInt, orderedEquals([1, 2, 3]));
      expect(generatedDouble, orderedEquals([1.0, 2.0, 3.0]));
    });

    test('exclusiveRange()', () {
      final generated = exclusiveRange(1, 5);

      final generatedInt    = exclusiveRange<int>(1, 5);
      final generatedDouble = exclusiveRange<double>(1.0, 5.0);

      expect(generated, orderedEquals([2, 3, 4]));

      expect(generatedInt, orderedEquals([2, 3, 4]));
      expect(generatedDouble, orderedEquals([2.0, 3.0, 4.0]));
    });

    test('openClosedRange()', () {
      final generated = openClosedRange(1, 5);

      final generatedInt    = openClosedRange<int>(1, 5);
      final generatedDouble = openClosedRange<double>(1.0, 5.0);

      expect(generated, orderedEquals([2, 3, 4, 5]));

      expect(generatedInt, orderedEquals([2, 3, 4, 5]));
      expect(generatedDouble, orderedEquals([2.0, 3.0, 4.0, 5.0]));
    });

    test('closedOpenRange()', () {
      final generated = closedOpenRange(1, 5);

      final generatedInt    = closedOpenRange<int>(1, 5);
      final generatedDouble = closedOpenRange<double>(1.0, 5.0);

      expect(generated, orderedEquals([1, 2, 3, 4]));

      expect(generatedInt, orderedEquals([1, 2, 3, 4]));
      expect(generatedDouble, orderedEquals([1.0, 2.0, 3.0, 4.0]));
    });
  });

  group('Infinite Range', () {
    test('infiniteRange()', () {
      final generated = infiniteRange(1, 3).take(5);

      final generatedInt = infiniteRange<int>(1, 3).take(5);
      final generatedDouble = infiniteRange<double>(1.0, 3.0).take(5);

      expect(generated, orderedEquals([1, 4, 7, 10, 13]));

      expect(generatedInt, orderedEquals([1, 4, 7, 10, 13]));
      expect(generatedDouble, orderedEquals([1.0, 4.0, 7.0, 10.0, 13.0]));
    });

    test('openInfiniteRange()', () {
      final generated = openInfiniteRange(1, 3).take(5);

      final generatedInt = openInfiniteRange<int>(1, 3).take(5);
      final generatedDouble = openInfiniteRange<double>(1.0, 3.0).take(5);

      expect(generated, orderedEquals([4, 7, 10, 13, 16]));

      expect(generatedInt, orderedEquals([4, 7, 10, 13, 16]));
      expect(generatedDouble, orderedEquals([4.0, 7.0, 10.0, 13.0, 16.0]));
    });

    test('closedInfiniteRange()', () {
      final generated = closedInfiniteRange(1, 3).take(5);

      final generatedInt = closedInfiniteRange<int>(1, 3).take(5);
      final generatedDouble = closedInfiniteRange<double>(1.0, 3.0).take(5);

      expect(generated, orderedEquals([1, 4, 7, 10, 13]));

      expect(generatedInt, orderedEquals([1, 4, 7, 10, 13]));
      expect(generatedDouble, orderedEquals([1.0, 4.0, 7.0, 10.0, 13.0]));
    });
    
    test('toString()', () {
      final finite = range(1, 5);
      final infinite = infiniteRange(1);

      expect(finite.toString(), equals([1, 2, 3, 4].toString()));
      expect(infinite.toString(), equals([1, 2, 3, 4, 5, '...'].toString()));
    });
  });
}