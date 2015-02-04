# dart_range

A library which provide ways of generating a sequence of numbers.

## Basic Usage

`range()` method creates a Range object as follows:

    range(1, 5);    // [1, 2, 3, 4]
    range(1, 8, 2); // [1, 3, 5, 7]

Range class implements Iterable, so you can easily iterate over it:

    range(0, 3).forEach((e) => print(e)); // 0, 1, 2

For creating detailed ranges, you have:

    inclusiveRange(begin, end, [step]);  // [begin, end]
    exclusiveRange(begin, end, [step]);  // (begin, end)
    openClosedRange(begin, end, [step]); // (begin, end]
    closedOpenRange(begin, end, [step]); // [begin, end)

You can also create a infinite range:

    openInfiniteRange(begin, [step]);   // (begin, infinity)
    closedInfiniteRange(begin, [step]); // [begin, infinity)

If you need a type-specific range, please use:

    intRange(begin, end);
    inclusiveIntRange(begin, end);
    doubleRange(begin, end);
    inclusiveDoubleRange(begin, end);
    // and so on

