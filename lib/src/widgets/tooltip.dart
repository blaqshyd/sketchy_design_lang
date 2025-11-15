import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Basic tooltip that appears on hover.
class SketchyTooltip extends StatefulWidget {
  /// Creates a tooltip that displays [message] above [child].
  const SketchyTooltip({required this.message, required this.child, super.key});

  /// Text shown when hovering.
  final String message;

  /// Widget that triggers the tooltip.
  final Widget child;

  @override
  State<SketchyTooltip> createState() => _SketchyTooltipState();
}

class _SketchyTooltipState extends State<SketchyTooltip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          widget.child,
          if (_hovering)
            Positioned(
              top: -32,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colors.ink,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.message,
                  style: typography.label.copyWith(color: theme.colors.paper),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
