import 'package:flutter/widgets.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_text_case.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_icons.dart';
import 'sketchy_surface.dart';
import 'sketchy_text.dart';

/// Visual tones supported by [SketchyChip].
enum SketchyChipTone {
  /// Primary accent tone.
  accent,

  /// Neutral ink tone.
  neutral,
}

/// Pill-shaped label that can behave like a badge or interactive chip.
class SketchyChip extends StatelessWidget {
  /// General constructor used for both badges and chips.
  const SketchyChip({
    required String label,
    VoidCallback? onPressed,
    bool selected = false,
    bool compact = false,
    bool filled = false,
    SketchyChipTone tone = SketchyChipTone.neutral,
    TextCase? textCase,
    SketchyFill? fillStyle,
    SketchyIconSymbol? icon,
    bool iconOnly = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         selected: selected,
         compact: compact,
         filled: filled,
         tone: tone,
         textCase: textCase,
         fillStyle: fillStyle,
         icon: icon,
         iconOnly: iconOnly,
       );

  const SketchyChip._({
    required this.label,
    required this.onPressed,
    required this.selected,
    required this.compact,
    required this.filled,
    required this.tone,
    required this.fillStyle,
    required this.iconOnly,
    this.icon,
    this.textCase,
    super.key,
  });

  /// Selectable chip variant.
  const SketchyChip.choice({
    required String label,
    required bool selected,
    required VoidCallback onSelected,
    SketchyChipTone tone = SketchyChipTone.accent,
    TextCase? textCase,
    SketchyFill? fillStyle,
    SketchyIconSymbol? icon,
    bool iconOnly = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: onSelected,
         selected: selected,
         compact: false,
         filled: selected,
         tone: tone,
         textCase: textCase,
         fillStyle: fillStyle,
         icon: icon,
         iconOnly: iconOnly,
       );

  /// Non-interactive suggestion chip.
  const SketchyChip.suggestion({
    required String label,
    SketchyChipTone tone = SketchyChipTone.neutral,
    TextCase? textCase,
    SketchyFill? fillStyle,
    SketchyIconSymbol? icon,
    bool iconOnly = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: null,
         selected: false,
         compact: false,
         filled: false,
         tone: tone,
         textCase: textCase,
         fillStyle: fillStyle,
         icon: icon,
         iconOnly: iconOnly,
       );

  /// Compact, non-interactive style that mirrors the old badge widget.
  const SketchyChip.badge({
    required String label,
    SketchyChipTone tone = SketchyChipTone.neutral,
    TextCase? textCase,
    SketchyFill? fillStyle,
    SketchyIconSymbol? icon,
    bool iconOnly = false,
    Key? key,
  }) : this._(
         key: key,
         label: label,
         onPressed: null,
         selected: false,
         compact: true,
         filled: true,
         tone: tone,
         textCase: textCase,
         fillStyle: fillStyle,
         icon: icon,
         iconOnly: iconOnly,
       );

  /// Chip label text.
  final String label;

  /// Fires when tapped; null keeps the chip passive.
  final VoidCallback? onPressed;

  /// Whether the chip is currently selected.
  final bool selected;

  /// Uses smaller typography + padding when true.
  final bool compact;

  /// Forces a filled appearance even when not selected.
  final bool filled;

  /// Visual tone applied to fill/ink accents.
  final SketchyChipTone tone;

  /// Text casing transformation. If null, uses theme default.
  final TextCase? textCase;

  /// Optional override for the interior fill style.
  final SketchyFill? fillStyle;

  /// Optional icon symbol rendered before/without text.
  final SketchyIconSymbol? icon;

  /// When true, renders only the icon (no text).
  final bool iconOnly;

  Color _toneColor(SketchyThemeData theme) => switch (tone) {
    SketchyChipTone.accent => theme.primaryColor,
    SketchyChipTone.neutral => theme.inkColor,
  };

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final toneColor = _toneColor(theme);
      final shouldFill = filled || selected;
      final padding = compact
          ? const EdgeInsets.symmetric(horizontal: 10, vertical: 6)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      final textStyleBase = compact
          ? theme.typography.label
          : theme.typography.body;
      final textStyle = textStyleBase.copyWith(
        color: theme.inkColor,
        fontWeight: selected ? FontWeight.w700 : textStyleBase.fontWeight,
      );
      final fillColor = shouldFill
          ? toneColor.withValues(alpha: compact ? 0.35 : 0.2)
          : theme.paperColor;
      final effectiveFill = shouldFill
          ? (fillStyle ?? SketchyFill.hachure)
          : SketchyFill.none;

      final content = _buildContent(textStyle, theme);

      final surface = IntrinsicWidth(
        child: IntrinsicHeight(
          child: SketchySurface(
            padding: padding,
            fillColor: fillColor,
            strokeColor: theme.inkColor,
            createPrimitive: () => SketchyPrimitive.pill(fill: effectiveFill),
            child: content,
          ),
        ),
      );

      if (onPressed == null) return surface;
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(onTap: onPressed, child: surface),
      );
    },
  );

  Widget _buildContent(TextStyle style, SketchyThemeData theme) {
    final hasIcon = icon != null;
    final iconWidget = hasIcon
        ? SketchyIcon(icon: icon!, size: compact ? 14 : 18)
        : null;
    if (iconOnly && iconWidget != null) {
      return iconWidget;
    }
    final labelWidget = SketchyText(label, textCase: textCase, style: style);
    if (iconWidget == null) return labelWidget;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [iconWidget, const SizedBox(width: 6), labelWidget],
    );
  }
}
