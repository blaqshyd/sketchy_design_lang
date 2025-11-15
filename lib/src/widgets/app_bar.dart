import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';

/// Rough-styled app bar used by Sketchy screens.
class SketchyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Creates a sketchy app bar with the given [title].
  const SketchyAppBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
  });

  /// Title widget displayed at the center.
  final Widget title;

  /// Optional action widgets rendered on the trailing edge.
  final List<Widget>? actions;

  /// Optional leading widget (e.g., back button).
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    return Container(
      height: preferredSize.height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(color: theme.colors.paper),
        drawConfig: DrawConfig.build(seed: 9, curveFitting: 0.8, bowing: 1),
      ),
      child: Row(
        children: [
          leading ?? const SizedBox.shrink(),
          if (leading != null) const SizedBox(width: 12),
          Expanded(
            child: DefaultTextStyle(
              style: theme.typography.title.copyWith(color: theme.colors.ink),
              child: title,
            ),
          ),
          if (actions != null && actions!.isNotEmpty) ...[
            const SizedBox(width: 8),
            ...actions!.map(
              (widget) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: widget,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
