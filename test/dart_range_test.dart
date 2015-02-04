import 'package:unittest/unittest.dart';
import 'package:dart_range/dart_range.dart';

void main() {
  group("Finite Range", () {
    test("range()", () {
      var generated = range(5, 10);
      expect(generated, orderedEquals([5, 6, 7, 8, 9]));
    });

    test("range() with a step", () {
      var generated1 = range(1, 6, 2);
      var generated2 = range(1, 7, 2);

      var generatedInt    = intRange(1, 7, 2);
      var generatedDouble = doubleRange(1.0, 7.0, 2.0);

      expect(generated1, orderedEquals([1, 3, 5]));
      expect(generated2, orderedEquals([1, 3, 5]));

      expect(generatedInt, orderedEquals([1, 3, 5]));
      expect(generatedDouble, orderedEquals([1.0, 3.0, 5.0]));
    });

    test("range() with a negative step", () {
      var generated1 = range(1, -6, -2);
      var generated2 = range(1, -7, -2);

      var generatedInt    = intRange(1, -7, -2);
      var generatedDouble = doubleRange(1.0, -7.0, -2.0);

      expect(generated1, orderedEquals([1, -1, -3, -5]));
      expect(generated2, orderedEquals([1, -1, -3, -5]));

      expect(generatedInt, orderedEquals([1, -1, -3, -5]));
      expect(generatedDouble, orderedEquals([1.0, -1.0, -3.0, -5.0]));
    });

    test("range() with a reverse step", () {
      var generated1 = range(-1, 5, -1);
      var generated2 = range(1, -5, 1);

      var generatedInt    = intRange(1, -5, 1);
      var generatedDouble = doubleRange(1.0, -5.0, 1.0);

      expect(generated1, isEmpty);
      expect(generated2, isEmpty);

      expect(generatedInt, isEmpty);
      expect(generatedDouble, isEmpty);
    });

    test("range() with 0 step", () {
      expect(() => range(1, 2, 0), throwsArgumentError);
    });

    test("inclusiveRange()", () {
      var generated = inclusiveRange(1, 3);

      var generatedInt    = inclusiveIntRange(1, 3);
      var generatedDouble = inclusiveDoubleRange(1.0, 3.0);

      expect(generated, orderedEquals([1, 2, 3]));

      expect(generatedInt, orderedEquals([1, 2, 3]));
      expect(generatedDouble, orderedEquals([1.0, 2.0, 3.0]));
    });

    test("exclusiveRange()", () {
      var generated = exclusiveRange(1, 5);

      var generatedInt    = exclusiveIntRange(1, 5);
      var generatedDouble = exclusiveDoubleRange(1.0, 5.0);

      expect(generated, orderedEquals([2, 3, 4]));

      expect(generatedInt, orderedEquals([2, 3, 4]));
      expect(generatedDouble, orderedEquals([2.0, 3.0, 4.0]));
    });

    test("openClosedRange()", () {
      var generated = openClosedRange(1, 5);

      var generatedInt    = openClosedIntRange(1, 5);
      var generatedDouble = openClosedDoubleRange(1.0, 5.0);

      expect(generated, orderedEquals([2, 3, 4, 5]));

      expect(generatedInt, orderedEquals([2, 3, 4, 5]));
      expect(generatedDouble, orderedEquals([2.0, 3.0, 4.0, 5.0]));
    });

    test("closedOpenRange()", () {
      var generated = closedOpenRange(1, 5);

      var generatedInt    = closedOpenRange(1, 5);
      var generatedDouble = closedOpenRange(1.0, 5.0);

      expect(generated, orderedEquals([1, 2, 3, 4]));

      expect(generatedInt, orderedEquals([1, 2, 3, 4]));
      expect(generatedDouble, orderedEquals([1.0, 2.0, 3.0, 4.0]));
    });
  });

  group("Infinite Range", () {
    test("infiniteRange()", () {
      var generated = infiniteRange(1, 3).take(5);

      expect(generated, orderedEquals([1, 4, 7, 10, 13]));
    });

    test("openInfiniteRange()", () {
      var generated = openInfiniteRange(1, 3).take(5);

      expect(generated, orderedEquals([4, 7, 10, 13, 16]));
    });

    test("closedInfiniteRange()", () {
      var generated = closedInfiniteRange(1, 3).take(5);

      expect(generated, orderedEquals([1, 4, 7, 10, 13]));
    });
  });
}