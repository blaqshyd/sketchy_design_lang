import 'package:flutter/widgets.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_theme.dart';
import 'surface.dart';

export '../primitives/sketchy_primitives.dart' show SketchyFill;

/// The shape of the frame.
enum SketchyFrameShape {
  /// A rectangular frame.
  rectangle,

  /// A circular frame.
  circle,
}

/// Convenience wrapper around [SketchySurface] that builds common frame shapes.
class SketchyFrame extends StatelessWidget {
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
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final primitive = _buildPrimitive();
      return SketchySurface(
        width: width,
        height: height,
        padding: padding,
        alignment: alignment,
        strokeColor: strokeColor ?? theme.colors.ink,
        fillColor: fillColor ?? const Color(0x00000000),
        strokeWidth: strokeWidth ?? theme.strokeWidth,
        createPrimitive: primitive,
        child: child,
      );
    },
  );

  SketchyPrimitive Function() _buildPrimitive() {
    switch (shape) {
      case SketchyFrameShape.circle:
        return () =>
            SketchyPrimitive.circle(fill: fill, fillOptions: fillOptions);
      case SketchyFrameShape.rectangle:
        final radius = cornerRadius ?? 0;
        if (radius > 0) {
          return () => SketchyPrimitive.roundedRectangle(
            fill: fill,
            cornerRadius: radius,
            fillOptions: fillOptions,
          );
        }
        return () =>
            SketchyPrimitive.rectangle(fill: fill, fillOptions: fillOptions);
    }
  }
}
