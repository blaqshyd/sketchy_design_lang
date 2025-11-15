import 'package:flutter/widgets.dart';
import 'package:wired_elements/wired_elements.dart';

import '../theme/sketchy_typography.dart';

/// Rough-styled toggle switch.
class SketchySwitch extends StatelessWidget {
  /// Creates a switch bound to [value].
  const SketchySwitch({required this.value, super.key, this.onChanged});

  /// Current on/off state.
  final bool value;

  /// Callback invoked when the switch changes state.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) => WiredToggle(
    value: value,
    onChange: (next) {
      if (onChanged == null) return false;
      onChanged!(next);
      return true;
    },
  );
}

/// Convenience widget that pairs [SketchySwitch] with a label.
class SketchySwitchTile extends StatelessWidget {
  /// Creates a labeled switch tile.
  const SketchySwitchTile({
    required this.label,
    required this.value,
    super.key,
    this.onChanged,
  });

  /// Label rendered next to the switch.
  final String label;

  /// Current switch value.
  final bool value;

  /// Callback invoked when toggled.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final typography = SketchyTypography.of(context);
    return Row(
      children: [
        Expanded(child: Text(label, style: typography.body)),
        SketchySwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}
