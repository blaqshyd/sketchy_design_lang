import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';

/// Container with a hand-drawn border and optional padding.
class SketchyCard extends StatelessWidget {
  /// Creates a new sketchy card wrapping [child].
  const SketchyCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.height,
  });

  /// Content rendered inside the card.
  final Widget child;

  /// Inner padding applied around [child].
  final EdgeInsetsGeometry padding;

  /// Optional fixed height.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final decorated = Container(padding: padding, child: child);

    return Container(
      height: height,
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(color: theme.colors.paper),
        drawConfig: DrawConfig.build(curveFitting: 0.9, bowing: 1),
        filler: ZigZagFiller(),
      ),
      child: decorated,
    );
  }
}
