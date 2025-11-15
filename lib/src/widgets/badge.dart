import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Tones supported by [SketchyBadge].
enum SketchyBadgeTone {
  /// Informational tone.
  info,

  /// Accent tone for primary emphasis.
  accent,

  /// Success tone.
  success,

  /// Neutral ink tone.
  neutral,
}

/// Pill-shaped label used for tagging content.
class SketchyBadge extends StatelessWidget {
  /// Creates a badge with the provided [label] and [tone].
  const SketchyBadge({
    required this.label,
    super.key,
    this.tone = SketchyBadgeTone.info,
  });

  /// Text displayed inside the badge.
  final String label;

  /// Visual tone applied to the badge fill.
  final SketchyBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);
    final color = switch (tone) {
      SketchyBadgeTone.info => theme.colors.info,
      SketchyBadgeTone.accent => theme.colors.accent,
      SketchyBadgeTone.success => theme.colors.success,
      SketchyBadgeTone.neutral => theme.colors.ink,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(color: color.withValues(alpha: 0.2)),
        shape: RoughBoxShape.rectangle,
        drawConfig: DrawConfig.build(bowing: 1, curveFitting: 0.8),
      ),
      child: Text(
        label,
        style: typography.label.copyWith(color: theme.colors.ink),
      ),
    );
  }
}
