# dart_range

Simple range iterator.

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

    inifiniteRange(begin, [step]);      // [begin, infinity)
    openInfiniteRange(begin, [step]);   // (begin, infinity)
    closedInfiniteRange(begin, [step]); // same as infiniteRange 

If you need a type-specific range, please use:

    range<int>(begin, end);
    inclusiveRange<int>(begin, end);
    range<double>(begin, end);
    inclusiveRange<double>(begin, end);
    // and so on

