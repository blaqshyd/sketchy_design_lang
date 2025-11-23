import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_surface.dart';
import 'value_sync_mixin.dart';

/// Sketchy checkbox.
///
/// Usage:
/// ```dart
/// Checkbox(
///   value: false,
///   onChanged: (value) {
/// 	print('Checkbox toggled: $value');
///   },
/// ),
/// ```
class SketchyCheckbox extends StatefulWidget {
  /// Creates a sketchy checkbox with the provided [value] and [onChanged].
  const SketchyCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Determines the checkbox checked or not.
  final bool? value;

  /// Called once the checkbox check status changes.
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool?) onChanged;

  @override
  State<SketchyCheckbox> createState() => _SketchyCheckboxState();
}

class _SketchyCheckboxState extends State<SketchyCheckbox>
    with ValueSyncMixin<bool, SketchyCheckbox> {
  @override
  bool get widgetValue => widget.value!;

  @override
  bool getOldWidgetValue(SketchyCheckbox oldWidget) => oldWidget.value!;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => GestureDetector(
      onTap: () {
        final newValue = !value;
        updateValue(newValue);
        widget.onChanged(newValue);
      },
      child: SketchySurface(
        width: 27,
        height: 27,
        strokeColor: theme.borderColor,
        strokeWidth: theme.strokeWidth,
        fillColor: theme.secondaryColor,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        createPrimitive: () =>
            SketchyPrimitive.rectangle(fill: SketchyFill.none),
        child: value
            ? Transform.scale(
                scale: 0.7,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CustomPaint(
                    painter: _SketchyCheckPainter(
                      color: theme.inkColor,
                      roughness: theme.roughness,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    ),
  );
}

class _SketchyCheckPainter extends CustomPainter {
  _SketchyCheckPainter({required this.color, required this.roughness});

  final Color color;
  final double roughness;

  @override
  void paint(Canvas canvas, Size size) {
    // Use seed for consistent randomness per instance (if we had instance ID,
    // but here we just want rough drawing).
    final generator = SketchyGenerator.createGenerator(
      seed: 1,
      roughness: roughness,
    );

    // Base inset
    const inset = 4.0;
    // Calculate variance based on roughness.
    // Higher roughness = more deviation from the center/corners.
    final variance = roughness * 3.0;

    // We'll use pseudo-random logic or just deterministic offsets based on
    // roughness to create "unevenness".
    // Line 1: Top-Left to Bottom-Right (longer line)
    final x1 = inset + (variance * 0.5);
    final y1 = inset - (variance * 0.2);
    final x2 = size.width - inset - (variance * 0.8) + 2;
    final y2 = size.height - inset + (variance * 0.4) + 2;

    // Line 2: Top-Right to Bottom-Left
    final x3 = size.width - inset + (variance * 0.3);
    final y3 = inset + (variance * 0.6);
    final x4 = inset - (variance * 0.4);
    final y4 = size.height - inset - (variance * 0.2);

    final drawable = generator.linearPath([PointD(x1, y1), PointD(x2, y2)]);
    final drawable2 = generator.linearPath([PointD(x3, y3), PointD(x4, y4)]);

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas
      ..drawRough(drawable, paint, paint)
      ..drawRough(drawable2, paint, paint);
  }

  @override
  bool shouldRepaint(_SketchyCheckPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.roughness != roughness;
}
