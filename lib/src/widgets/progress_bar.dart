import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';

/// Linear progress indicator drawn with rough strokes.
class SketchyProgressBar extends StatelessWidget {
  /// Creates a progress bar with the provided [value].
  const SketchyProgressBar({required this.value, super.key});

  /// Completion value between 0 and 1.
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    return Container(
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colors.ink, width: theme.strokeWidth),
      ),
      child: FractionallySizedBox(
        widthFactor: value.clamp(0, 1),
        alignment: Alignment.centerLeft,
        child: Container(color: theme.colors.accentMuted),
      ),
    );
  }
}
