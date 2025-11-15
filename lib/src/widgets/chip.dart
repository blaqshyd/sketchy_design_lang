import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Choice chip rendered with rough outlines.
class SketchyChip extends StatelessWidget {
  const SketchyChip._({
    required this.label,
    required this.selected,
    required this.onSelected,
    required this.filled,
    super.key,
  });

  /// Selectable chip variant.
  const SketchyChip.choice({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         selected: selected,
         onSelected: onSelected,
         filled: true,
       );

  /// Non-interactive suggestion chip.
  const SketchyChip.suggestion({required String label, Key? key})
    : this._(
        key: key,
        label: label,
        selected: false,
        onSelected: null,
        filled: false,
      );

  /// Chip label text.
  final String label;

  /// Whether the chip is currently selected.
  final bool selected;

  /// Callback invoked when the chip is tapped.
  final VoidCallback? onSelected;

  /// Whether the chip draws a filled background.
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);
    final bgColor = filled && selected
        ? theme.colors.accentMuted
        : theme.colors.paper;

    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(color: bgColor),
      ),
      child: Text(
        label,
        style: typography.body.copyWith(
          color: theme.colors.ink,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );

    if (onSelected == null) return chip;
    return GestureDetector(onTap: onSelected, child: chip);
  }
}
