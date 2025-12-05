import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../theme/sketchy_text_case.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_text.dart' as sketchy;

/// Basic tooltip that appears on hover similar to Flutter's Material tooltip.
class SketchyTooltip extends StatefulWidget {
  /// Creates a tooltip that displays [message] near the pointer.
  const SketchyTooltip({
    required this.message,
    required this.child,
    this.textCase,
    super.key,
  });

  /// Text shown when hovering.
  final String message;

  /// Widget that triggers the tooltip.
  final Widget child;

  /// Text casing transformation. If null, uses theme default.
  final TextCase? textCase;

  @override
  State<SketchyTooltip> createState() => _SketchyTooltipState();
}

class _SketchyTooltipState extends State<SketchyTooltip> {
  OverlayEntry? _entry;
  Timer? _showTimer;
  Offset? _lockedPosition;

  @override
  Widget build(BuildContext context) => Listener(
    onPointerDown: (_) => _hideTooltip(),
    child: MouseRegion(
      opaque: true,
      onEnter: (event) => _startShowTimer(event.position),
      onHover: (event) => _updatePendingPosition(event.position),
      onExit: (_) => _hideTooltip(),
      child: widget.child,
    ),
  );

  void _updatePendingPosition(Offset position) {
    // Only update position if tooltip hasn't been shown yet
    if (_entry == null && _showTimer != null) {
      _lockedPosition = position;
    }
    // Once shown, position stays locked - don't update
  }

  void _startShowTimer(Offset position) {
    _lockedPosition = position;
    _showTimer?.cancel();
    _showTimer = Timer(const Duration(seconds: 2), _showTooltip);
  }

  void _showTooltip() {
    if (_entry != null) return;
    _entry = OverlayEntry(
      builder: (context) => _TooltipOverlay(
        message: widget.message,
        target: _lockedPosition ?? _fallbackPosition(),
        textCase: widget.textCase,
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  Offset _fallbackPosition() {
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      return renderBox.localToGlobal(renderBox.size.center(Offset.zero));
    }
    return Offset.zero;
  }

  void _hideTooltip() {
    _showTimer?.cancel();
    _showTimer = null;
    _entry?.remove();
    _entry = null;
    _lockedPosition = null;
  }

  @override
  void dispose() {
    _hideTooltip();
    super.dispose();
  }
}

class _TooltipOverlay extends StatelessWidget {
  const _TooltipOverlay({
    required this.message,
    required this.target,
    this.textCase,
  });

  final String message;
  final Offset target;
  final TextCase? textCase;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final casing = textCase ?? theme.textCase;
      final displayMessage = applyTextCase(message, casing);
      final textPainter = TextPainter(
        text: TextSpan(text: displayMessage, style: theme.typography.label),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: MediaQuery.of(context).size.width * 0.8);
      final tooltipSize = Size(textPainter.width + 16, textPainter.height + 8);
      final offset = _computeTooltipOffset(
        target,
        tooltipSize,
        MediaQuery.of(context).size,
      );

      return Positioned(
        left: offset.dx,
        top: offset.dy,
        child: IgnorePointer(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.inkColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: sketchy.SketchyText(
              message,
              textCase: textCase,
              style: theme.typography.label.copyWith(color: theme.paperColor),
            ),
          ),
        ),
      );
    },
  );
}

Offset _computeTooltipOffset(Offset target, Size tooltipSize, Size screenSize) {
  // Standard cursor is ~12px wide, ~16px tall from hotspot (top-left)
  // Position tooltip 8px to the right of cursor and 8px below cursor
  const cursorWidth = 12.0;
  const cursorHeight = 16.0;
  const gap = 8.0;

  // Position 8px to the right of the cursor's right edge
  var x = target.dx + cursorWidth + gap;
  // Clamp: right edge of tooltip must not exceed right edge of window
  final maxX = screenSize.width - tooltipSize.width;
  x = math.min(math.max(x, 0), maxX);

  // Position 8px below the cursor's bottom edge
  var y = target.dy + cursorHeight + gap;
  // Clamp: bottom edge of tooltip must not exceed bottom edge of window
  final maxY = screenSize.height - tooltipSize.height;
  y = math.min(math.max(y, 0), maxY);

  return Offset(x, y);
}
