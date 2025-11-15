import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Alignment options for [SketchyListTile].
enum SketchyTileAlignment {
  /// Bubble aligns to the start (left in LTR).
  start,

  /// Bubble aligns to the end (right in LTR).
  end,
}

/// Sketchy-styled list tile widget.
class SketchyListTile extends StatelessWidget {
  /// Creates a new list tile with optional leading/trailing widgets.
  const SketchyListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.alignment = SketchyTileAlignment.start,
  });

  /// Widget placed before the title.
  final Widget? leading;

  /// Primary label widget.
  final Widget? title;

  /// Secondary label widget.
  final Widget? subtitle;

  /// Widget placed at the end of the row.
  final Widget? trailing;

  /// Tap handler for the tile.
  final VoidCallback? onTap;

  /// Alignment of the bubble (start for agent, end for customer, etc.).
  final SketchyTileAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);

    final content = Container(
      padding: const EdgeInsets.all(12),
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(
          color: alignment == SketchyTileAlignment.start
              ? theme.colors.paper
              : theme.colors.accentMuted.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 12)],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style: typography.body.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    child: title!,
                  ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  DefaultTextStyle(style: typography.caption, child: subtitle!),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[const SizedBox(width: 12), trailing!],
        ],
      ),
    );

    final bubble = alignment == SketchyTileAlignment.end
        ? Align(alignment: Alignment.centerRight, child: content)
        : Align(alignment: Alignment.centerLeft, child: content);

    if (onTap == null) return bubble;
    return GestureDetector(onTap: onTap, child: bubble);
  }
}
