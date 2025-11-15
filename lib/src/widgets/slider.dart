import 'package:flutter/widgets.dart';
import 'package:wired_elements/wired_elements.dart';

/// Rough-styled slider built on top of [WiredSlider].
class SketchySlider extends StatelessWidget {
  /// Creates a slider with the provided [value], [min], and [max].
  const SketchySlider({
    required this.value,
    super.key,
    this.min = 0,
    this.max = 1,
    this.onChanged,
  });

  /// Current slider value.
  final double value;

  /// Minimum selectable value.
  final double min;

  /// Maximum selectable value.
  final double max;

  /// Callback invoked when the slider value changes.
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) => WiredSlider(
    value: value,
    min: min,
    max: max,
    onChanged: (next) {
      if (onChanged == null) return false;
      onChanged!(next);
      return true;
    },
  );
}
