import 'package:flutter/material.dart' show DropdownMenuItem;
import 'package:flutter/widgets.dart';
import 'package:wired_elements/wired_elements.dart';

import '../theme/sketchy_typography.dart';

/// Sketchy wrapper around [WiredCombo].
class SketchyDropdown<T> extends StatelessWidget {
  /// Creates a dropdown with the given [items] and [label].
  const SketchyDropdown({
    required this.label,
    required this.items,
    super.key,
    this.value,
    this.onChanged,
  });

  /// Field label shown above the dropdown.
  final String label;

  /// Options the user may select from.
  final List<T> items;

  /// Currently selected value.
  final T? value;

  /// Callback invoked when the selection changes.
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final typography = SketchyTypography.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: typography.body),
        const SizedBox(height: 8),
        WiredCombo(
          value: value,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(item.toString(), style: typography.body),
                  ),
                ),
              )
              .toList(),
          onChanged: (dynamic selected) => onChanged?.call(selected as T?),
        ),
      ],
    );
  }
}
