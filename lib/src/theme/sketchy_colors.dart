import 'package:flutter/painting.dart';

/// Palette describing the “ink and paper” colors Sketchy components use.
class SketchyColors {
  /// Creates a palette with the provided role colors.
  const SketchyColors({
    required this.ink,
    required this.paper,
    required this.accent,
    required this.accentMuted,
    required this.info,
    required this.warning,
    required this.success,
  });

  /// Primary stroke color used for outlines and text.
  final Color ink;

  /// Background color emulating paper.
  final Color paper;

  /// Bold accent color for primary actions.
  final Color accent;

  /// Softer accent variant for fills.
  final Color accentMuted;

  /// Informational accent color.
  final Color info;

  /// Warning accent color.
  final Color warning;

  /// Success accent color.
  final Color success;

  /// Returns a copy of this palette with the provided overrides.
  SketchyColors copyWith({
    Color? ink,
    Color? paper,
    Color? accent,
    Color? accentMuted,
    Color? info,
    Color? warning,
    Color? success,
  }) => SketchyColors(
    ink: ink ?? this.ink,
    paper: paper ?? this.paper,
    accent: accent ?? this.accent,
    accentMuted: accentMuted ?? this.accentMuted,
    info: info ?? this.info,
    warning: warning ?? this.warning,
    success: success ?? this.success,
  );
}
