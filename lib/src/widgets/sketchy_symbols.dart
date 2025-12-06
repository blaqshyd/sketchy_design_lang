import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_theme.dart';

/// Symbols supported by [SketchySymbol].
enum SketchySymbols {
  /// Plus icon.
  plus,

  /// Chevron pointing to the right.
  chevronRight,

  /// Chevron pointing down.
  chevronDown,

  /// Rectangle outline.
  rectangle,

  /// Paper-plane "send" icon.
  send,

  /// Solid bullet (filled circle).
  bullet,

  /// Close/Cancel icon (X).
  x,

  /// Hash/pound symbol (#).
  hash,

  /// Menu (hamburger) icon.
  menu,

  /// External link icon (arrow pointing out of box).
  externalLink,

  /// Gear/settings icon.
  gear,

  /// People/users icon.
  people,

  /// Checkmark icon.
  check,
}

/// Custom painter-based symbol rendered in the sketch style using
/// rough_flutter.
class SketchySymbol extends StatelessWidget {
  /// Creates an icon for the given [symbol].
  const SketchySymbol({
    required this.symbol,
    super.key,
    this.size = 20,
    this.color,
  });

  /// Symbol to draw.
  final SketchySymbols symbol;

  /// Visual size of the icon.
  final double size;

  /// Optional override for the ink color.
  final Color? color;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SketchySymbolPainter(
          symbol: symbol,
          color: color ?? theme.inkColor,
          roughness: theme.roughness,
        ),
      ),
    ),
  );
}

class _SketchySymbolPainter extends CustomPainter {
  _SketchySymbolPainter({
    required this.symbol,
    required this.color,
    required this.roughness,
  });

  final SketchySymbols symbol;
  final Color color;
  final double roughness;

  @override
  void paint(Canvas canvas, Size size) {
    final generator = SketchyGenerator.createGenerator(
      seed: symbol.hashCode, // Stable seed based on symbol
      roughness: roughness,
    );

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Helper to draw a list of drawables
    void draw(List<Drawable> drawables) {
      final fillPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      for (final d in drawables) {
        canvas.drawRough(d, paint, fillPaint);
      }
    }

    switch (symbol) {
      case SketchySymbols.plus:
        draw([
          generator.line(size.width / 2, 2, size.width / 2, size.height - 2),
          generator.line(2, size.height / 2, size.width - 2, size.height / 2),
        ]);
      case SketchySymbols.chevronRight:
        draw([
          generator.linearPath([
            PointD(4, 4),
            PointD(size.width - 4, size.height / 2),
            PointD(4, size.height - 4),
          ]),
        ]);
      case SketchySymbols.chevronDown:
        draw([
          generator.linearPath([
            PointD(4, 4),
            PointD(size.width / 2, size.height - 4),
            PointD(size.width - 4, 4),
          ]),
        ]);
      case SketchySymbols.rectangle:
        draw([generator.rectangle(2, 2, size.width - 4, size.height - 4)]);
      case SketchySymbols.send:
        draw([
          generator.polygon([
            PointD(2, size.height - 2),
            PointD(size.width - 2, size.height / 2),
            PointD(2, 2),
            PointD(size.width / 3, size.height / 2),
          ]),
        ]);
      case SketchySymbols.bullet:
        // Solid fill (clean)
        canvas.drawOval(
          Rect.fromLTWH(2, 2, size.width - 4, size.height - 4),
          Paint()
            ..color = color
            ..style = PaintingStyle.fill,
        );
        // Rough outline
        draw([
          generator.ellipse(
            size.width / 2,
            size.height / 2,
            size.width - 4,
            size.height - 4,
          ),
        ]);
      case SketchySymbols.x:
        const inset = 4.0;
        draw([
          generator.line(inset, inset, size.width - inset, size.height - inset),
          generator.line(size.width - inset, inset, inset, size.height - inset),
        ]);
      case SketchySymbols.hash:
        // # symbol
        final w = size.width;
        final h = size.height;
        draw([
          // Vertical lines
          generator.line(w * 0.35, h * 0.1, w * 0.25, h * 0.9),
          generator.line(w * 0.75, h * 0.1, w * 0.65, h * 0.9),
          // Horizontal lines
          generator.line(w * 0.1, h * 0.35, w * 0.9, h * 0.35),
          generator.line(w * 0.1, h * 0.65, w * 0.9, h * 0.65),
        ]);
      case SketchySymbols.menu:
        // Hamburger menu
        final w = size.width;
        final h = size.height;
        draw([
          generator.line(w * 0.15, h * 0.25, w * 0.85, h * 0.25),
          generator.line(w * 0.15, h * 0.5, w * 0.85, h * 0.5),
          generator.line(w * 0.15, h * 0.75, w * 0.85, h * 0.75),
        ]);
      case SketchySymbols.externalLink:
        // Arrow pointing out of a box (Font Awesome style)
        final w = size.width;
        final h = size.height;
        draw([
          // Box (open on top-right corner)
          generator.linearPath([
            PointD(w * 0.55, h * 0.15),
            PointD(w * 0.15, h * 0.15),
            PointD(w * 0.15, h * 0.85),
            PointD(w * 0.85, h * 0.85),
            PointD(w * 0.85, h * 0.45),
          ]),
          // Arrow line
          generator.line(w * 0.45, h * 0.55, w * 0.85, h * 0.15),
          // Arrow head
          generator.line(w * 0.85, h * 0.15, w * 0.6, h * 0.15),
          generator.line(w * 0.85, h * 0.15, w * 0.85, h * 0.4),
        ]);
      case SketchySymbols.gear:
        // Gear/cog icon
        final cx = size.width / 2;
        final cy = size.height / 2;
        final outerR = size.width * 0.45;
        final innerR = size.width * 0.25;
        // Draw center circle
        draw([generator.ellipse(cx, cy, innerR * 2, innerR * 2)]);
        // Draw gear teeth (8 teeth)
        for (var i = 0; i < 8; i++) {
          final angle = i * math.pi / 4;
          final cosA = math.cos(angle);
          final sinA = math.sin(angle);
          draw([
            generator.line(
              cx + innerR * 0.8 * cosA,
              cy + innerR * 0.8 * sinA,
              cx + outerR * cosA,
              cy + outerR * sinA,
            ),
          ]);
        }
      case SketchySymbols.people:
        // Two people silhouettes
        final w = size.width;
        final h = size.height;
        // Front person (larger, centered-right)
        draw([
          // Head
          generator.ellipse(w * 0.6, h * 0.25, w * 0.28, h * 0.28),
          // Body arc
          generator.arc(
            w * 0.6,
            h * 0.9,
            w * 0.5,
            h * 0.6,
            math.pi,
            math.pi * 2,
            false,
          ),
        ]);
        // Back person (smaller, left)
        draw([
          // Head
          generator.ellipse(w * 0.32, h * 0.3, w * 0.22, h * 0.22),
          // Body arc
          generator.arc(
            w * 0.32,
            h * 0.85,
            w * 0.38,
            h * 0.5,
            math.pi,
            math.pi * 2,
            false,
          ),
        ]);
      case SketchySymbols.check:
        // Checkmark
        draw([
          generator.linearPath([
            PointD(size.width * 0.15, size.height * 0.5),
            PointD(size.width * 0.4, size.height * 0.75),
            PointD(size.width * 0.85, size.height * 0.2),
          ]),
        ]);
    }
  }

  @override
  bool shouldRepaint(covariant _SketchySymbolPainter oldDelegate) =>
      oldDelegate.symbol != symbol ||
      oldDelegate.color != color ||
      oldDelegate.roughness != roughness;
}
