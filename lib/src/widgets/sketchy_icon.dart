import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';

/// A wrapper for external icons (like `FaIcon` or `Icon`) to ensure they
/// inherit Sketchy styling explicitly.
///
/// While [SketchyTheme] provides a default [IconTheme], this widget is useful
/// when you need to override size or color specifically while staying within
/// the design system's constraints.
class SketchyIcon extends StatelessWidget {
  /// Creates a sketchy icon wrapper.
  const SketchyIcon({
    required this.child,
    super.key,
    this.size,
    this.color,
  });

  /// The icon widget to wrap.
  final Widget child;

  /// Visual size of the icon.
  final double? size;

  /// Optional override for the ink color.
  final Color? color;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final effectiveColor = color ?? theme.inkColor;
      final effectiveSize = size ?? 20.0;

      return IconTheme(
        data: IconThemeData(color: effectiveColor, size: effectiveSize),
        child: child,
      );
    },
  );
}
