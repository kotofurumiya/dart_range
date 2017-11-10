/// Simple range iterator.
library dart_range;

import 'dart:collection';

/// Create a new [[begin], [end]) [Range] object with [step].
Range<T> range<T extends num>(T begin, T end, [T step = null]) =>
    closedOpenRange<T>(begin, end, step);

/// Create a new [[begin], [end]] [Range] object with [step].
Range<T> inclusiveRange<T extends num>(T begin, T end, [T step = null]) {
  step ??= (T is double) ? 1.0 : 1;
  return new FiniteRange<T>.inclusive(begin, end, step);
}

/// Create a new ([begin], [end]) [Range] object with [step].
Range<T> exclusiveRange<T extends num>(T begin, T end, [T step = null])  {
  step ??= (T is double) ? 1.0 : 1;
  return new FiniteRange<T>.exclusive(begin, end, step);
}

/// Create a new ([begin], [end]] [Range] object with [step].
Range<T> openClosedRange<T extends num>(T begin, T end, [T step = null]) {
  step ??= (T is double) ? 1.0 : 1;
  return new FiniteRange<T>.openClosed(begin, end, step);
}

/// Create a new [[begin], [end]) [Range] object with [step].
Range<T> closedOpenRange<T extends num>(T begin, T end, [T step = null]) {
  step ??= (T is double) ? 1.0 : 1;
  return new FiniteRange<T>.closedOpen(begin, end, step);
}

/// Create a new [[begin], infinite) [Range] object with [step].
Range<T> infiniteRange<T extends num>(T begin, [T step = null]) {
  return closedInfiniteRange<T>(begin, step);
}

/// Create a new ([begin], infinite) [Range] object with [step].
Range<T> openInfiniteRange<T extends num>(T begin, [T step = null]) {
  step ??= (T is double) ? 1.0 : 1;
  return new InfiniteRange<T>.open(begin, step);
}

/// Create a new [[begin], infinite) [Range] object with [step].
Range<T> closedInfiniteRange<T extends num>(T begin, [T step = null]) {
  step ??= (T is double) ? 1.0 : 1;
  return new InfiniteRange<T>.closed(begin, step);
}

/// An interface of a sequence of numbers.
///
/// For more information about implementations,
/// see also [FiniteRange] and [InfiniteRange].
abstract class Range<T extends num> extends IterableBase<T> {
  /// Returns the begin value of the Range.
  T get begin;

  /// Returns the step value of the Range.
  T get step;

  /// Returns true if the Range includes the [begin] value; otherwise, false.
  bool get isBeginInclusive;

  void _validateFields() {
    if(step == 0) throw new ArgumentError("step must not be 0.");
  }
}

/// A finite sequence of numbers.
class FiniteRange<T extends num> extends Range<T> {
  final T begin;

  /// Returns the begin value of Range.
  final T end;

  final T step;

  final bool isBeginInclusive;

  /// Returns true if the Range includes the [end] value; otherwise, false.
  final bool isEndInclusive;

  FiniteRangeIterator<T> _iterator;

  /// Creates a new FiniteRange object.
  ///
  /// [begin], [end] or [step] can be negative.
  FiniteRange(this.begin, this.end, this.step,
              {this.isBeginInclusive: true, this.isEndInclusive: false}) {
    _validateFields();
  }

  /// Create a new [[begin], [end]] FiniteRange object with [step].
  FiniteRange.inclusive(T begin, T end, T step) : this(begin, end, step,
                                                       isBeginInclusive: true,
                                                       isEndInclusive: true);

  /// Create a new ([begin], [end]) FiniteRange object with [step].
  FiniteRange.exclusive(T begin, T end, T step) : this(begin, end, step,
                                                       isBeginInclusive: false,
                                                       isEndInclusive: false);

  /// Create a new ([begin], [end]] FiniteRange object with [step].
  FiniteRange.openClosed(T begin, T end, T step) : this(begin, end, step,
                                                        isBeginInclusive: false,
                                                        isEndInclusive: true);

  /// Create a new [[begin], [end]) FiniteRange object with [step].
  FiniteRange.closedOpen(T begin, T end, T step) : this(begin, end, step,
                                                        isBeginInclusive: true,
                                                        isEndInclusive: false);

  Iterator<T> get iterator =>
      new FiniteRangeIterator(begin, end, step,
                              isBeginInclusive: isBeginInclusive,
                              isEndInclusive: isEndInclusive);
}

/// An infinite sequence of numbers.
class InfiniteRange<T extends num> extends Range<T> {
  final T begin;
  final T step;
  final bool isBeginInclusive;

  InfiniteRangeIterator<T> _iterator;

  /// Creates a new InfiniteRange object.
  ///
  /// [begin], [step] can be negative.
  InfiniteRange(this.begin, this.step, {this.isBeginInclusive: true}) {
    _validateFields();
  }

  /// Create a new ([begin], infinity) InfiniteRange object with [step].
  InfiniteRange.open(T begin, T step) : this(begin, step,
                                             isBeginInclusive: false);

  /// Create a new [[begin], infinity) InfiniteRange object with [step].
  InfiniteRange.closed(T begin, T step) : this(begin, step,
                                               isBeginInclusive: true);

  Iterator<T> get iterator =>
      new InfiniteRangeIterator(begin, step, isBeginInclusive: isBeginInclusive);

  @override
  String toString() {
    var head = take(5).map((e) => e).toList();
    head.add("...");
    return head.toString();
  }
}

abstract class RangeIterator<T extends num> implements Iterator<T> {
  T get begin;
  T get step;
  bool get isBeginInclusive;
}

class FiniteRangeIterator<T extends num> implements RangeIterator<T> {
  final T begin;
  final T end;
  final T step;
  final bool isBeginInclusive;
  final bool isEndInclusive;
  T _currentValue;

  FiniteRangeIterator(this.begin, this.end, this.step,
                      {this.isBeginInclusive: true, this.isEndInclusive: false});

  bool moveNext() {
    var beginValue = isBeginInclusive ? begin : begin + step;
    _currentValue  = (_currentValue == null) ? beginValue : _currentValue + step;

    bool hasNext;
    if(step > 0) {
      hasNext = isEndInclusive ? _currentValue <= end : _currentValue < end;
    } else {
      hasNext = isEndInclusive ? _currentValue >= end : _currentValue > end;
    }

    if(!hasNext) _currentValue = null;

    return hasNext;
  }

  T get current => _currentValue;
}

class InfiniteRangeIterator<T extends num> implements RangeIterator<T> {
  final T begin;
  final T step;
  final bool isBeginInclusive;
  T _currentValue;

  InfiniteRangeIterator(this.begin, this.step,
                        {this.isBeginInclusive: true});

  bool moveNext() {
    var beginValue = isBeginInclusive ? begin : begin + step;
    _currentValue  = (_currentValue == null) ? beginValue : _currentValue + step;

    return true;
  }

  T get current => _currentValue;
}