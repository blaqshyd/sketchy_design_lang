import 'package:flutter/widgets.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_surface.dart';

/// Alignment options for [SketchyListTile].
enum SketchyTileAlignment {
  /// Bubble aligns to the start (left in LTR).
  start,

  /// Bubble aligns to the end (right in LTR).
  end,
}

/// Sketchy-styled list tile widget.
class SketchyListTile extends StatefulWidget {
  /// Creates a new list tile with optional leading/trailing widgets.
  const SketchyListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.alignment = SketchyTileAlignment.start,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
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

  /// Long press handler for the tile.
  final VoidCallback? onLongPress;

  /// Alignment of the bubble (start for agent, end for customer, etc.).
  final SketchyTileAlignment alignment;

  /// Whether this tile is selected.
  final bool selected;

  /// Whether this tile is enabled.
  final bool enabled;

  /// The tile's internal padding.
  final EdgeInsetsGeometry? contentPadding;

  @override
  State<SketchyListTile> createState() => _SketchyListTileState();
}

class _SketchyListTileState extends State<SketchyListTile> {
  SketchyPrimitive? _primitive;
  double? _lastBorderRadius;

  SketchyPrimitive _getPrimitive(double borderRadius) {
    if (_primitive == null || _lastBorderRadius != borderRadius) {
      _primitive = SketchyPrimitive.roundedRectangle(
        cornerRadius: borderRadius,
        fill: SketchyFill.solid,
      );
      _lastBorderRadius = borderRadius;
    }
    return _primitive!;
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final bubbleFill = widget.selected
          ? theme.secondaryColor
          : (widget.alignment == SketchyTileAlignment.start
                ? theme.paperColor
                : theme.secondaryColor.withValues(alpha: 0.5));

      final content = SketchySurface(
        padding: widget.contentPadding ?? const EdgeInsets.all(12),
        fillColor: bubbleFill,
        strokeColor: theme.inkColor,
        createPrimitive: () => _getPrimitive(theme.borderRadius),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.leading != null) ...[
              widget.leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.title != null)
                    DefaultTextStyle(
                      style: theme.typography.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.enabled
                            ? theme.textColor
                            : theme.disabledTextColor,
                      ),
                      child: widget.title!,
                    ),
                  if (widget.subtitle != null) ...[
                    const SizedBox(height: 4),
                    DefaultTextStyle(
                      style: theme.typography.caption.copyWith(
                        color: widget.enabled
                            ? theme.textColor
                            : theme.disabledTextColor,
                      ),
                      child: widget.subtitle!,
                    ),
                  ],
                ],
              ),
            ),
            if (widget.trailing != null) ...[
              const SizedBox(width: 12),
              widget.trailing!,
            ],
          ],
        ),
      );

      final bubble = widget.alignment == SketchyTileAlignment.end
          ? Align(alignment: Alignment.centerRight, child: content)
          : Align(alignment: Alignment.centerLeft, child: content);

      if (widget.onTap == null && widget.onLongPress == null) return bubble;
      if (!widget.enabled) return Opacity(opacity: 0.5, child: bubble);

      return GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: bubble,
      );
    },
  );
}
