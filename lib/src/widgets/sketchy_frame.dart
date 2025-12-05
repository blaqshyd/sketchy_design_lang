import 'package:flutter/widgets.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_surface.dart';

export '../primitives/sketchy_primitives.dart' show SketchyFill;

/// The shape of the frame.
enum SketchyFrameShape {
  /// A rectangular frame.
  rectangle,

  /// A circular frame.
  circle,
}

/// Convenience wrapper around [SketchySurface] that builds common frame shapes.
class SketchyFrame extends StatefulWidget {
  /// Creates a sketchy frame with the given [child].
  const SketchyFrame({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding = EdgeInsets.zero,
    this.strokeColor,
    this.fillColor,
    this.strokeWidth,
    this.fill = SketchyFill.none,
    this.shape = SketchyFrameShape.rectangle,
    this.cornerRadius,
    this.alignment = Alignment.center,
    this.fillOptions,
  });

  /// The widget to be framed.
  final Widget child;

  /// The width of the frame.
  final double? width;

  /// The height of the frame.
  final double? height;

  /// The padding of the frame.
  final EdgeInsetsGeometry padding;

  /// The color of the stroke.
  final Color? strokeColor;

  /// The color of the fill.
  final Color? fillColor;

  /// The width of the stroke.
  final double? strokeWidth;

  /// The fill style of the frame.
  final SketchyFill fill;

  /// The shape of the frame.
  final SketchyFrameShape shape;

  /// The corner radius of the frame.
  final double? cornerRadius;

  /// The alignment of the frame.
  final AlignmentGeometry? alignment;

  /// The fill options of the frame.
  final SketchyFillOptions? fillOptions;

  @override
  State<SketchyFrame> createState() => _SketchyFrameState();
}

class _SketchyFrameState extends State<SketchyFrame> {
  late final SketchyPrimitive _primitive;

  @override
  void initState() {
    super.initState();
    _primitive = _buildPrimitive();
  }

  SketchyPrimitive _buildPrimitive() {
    switch (widget.shape) {
      case SketchyFrameShape.circle:
        return SketchyPrimitive.circle(
          fill: widget.fill,
          fillOptions: widget.fillOptions,
        );
      case SketchyFrameShape.rectangle:
        final radius = widget.cornerRadius ?? 0;
        if (radius > 0) {
          return SketchyPrimitive.roundedRectangle(
            fill: widget.fill,
            cornerRadius: radius,
            fillOptions: widget.fillOptions,
          );
        }
        return SketchyPrimitive.rectangle(
          fill: widget.fill,
          fillOptions: widget.fillOptions,
        );
    }
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => SketchySurface(
      width: widget.width,
      height: widget.height,
      padding: widget.padding,
      alignment: widget.alignment,
      strokeColor: widget.strokeColor ?? theme.inkColor,
      fillColor: widget.fillColor ?? const Color(0x00000000),
      strokeWidth: widget.strokeWidth ?? theme.strokeWidth,
      createPrimitive: () => _primitive,
      child: widget.child,
    ),
  );
}
