import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';

/// Simple horizontal divider drawn with a faint ink color.
class SketchyDivider extends StatelessWidget {
  /// Creates a divider with optional [height].
  const SketchyDivider({super.key, this.height = 1});

  /// Thickness of the divider line.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    return Container(
      height: height,
      color: theme.colors.ink.withValues(alpha: 0.2),
    );
  }
}
