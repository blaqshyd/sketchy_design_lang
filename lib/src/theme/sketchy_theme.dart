import 'package:flutter/widgets.dart';

import 'sketchy_colors.dart';
import 'sketchy_typography.dart';

/// Complete Sketchy configuration (colors, typography, metrics).
class SketchyThemeData {
  /// Creates a theme with the provided palette and typography.
  const SketchyThemeData({
    required this.colors,
    required this.typography,
    this.strokeWidth = 2.0,
    this.borderRadius = 12.0,
  });

  /// Default light theme used by the examples.
  factory SketchyThemeData.light() {
    const colors = SketchyColors(
      ink: Color(0xFF1B1B1B),
      paper: Color(0xFFFFFBF5),
      accent: Color(0xFFFC7753),
      accentMuted: Color(0xFFFFC7B3),
      info: Color(0xFF4F7CAC),
      warning: Color(0xFFED6A5A),
      success: Color(0xFF6C9A8B),
    );

    return const SketchyThemeData(
      colors: colors,
      typography: SketchyTypographyData(
        headline: TextStyle(
          fontSize: 28,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        title: TextStyle(
          fontSize: 20,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
        body: TextStyle(fontSize: 16, height: 1.4),
        caption: TextStyle(fontSize: 14, height: 1.3),
        label: TextStyle(
          fontSize: 12,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Dark-mode variant built from a darker palette.
  factory SketchyThemeData.dark() {
    const colors = SketchyColors(
      ink: Color(0xFFF4F4F4),
      paper: Color(0xFF1A1A1A),
      accent: Color(0xFFFFB347),
      accentMuted: Color(0xFF795548),
      info: Color(0xFF80CBC4),
      warning: Color(0xFFF28B82),
      success: Color(0xFFA5D6A7),
    );

    return const SketchyThemeData(
      colors: colors,
      typography: SketchyTypographyData(
        headline: TextStyle(
          fontSize: 28,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
        title: TextStyle(
          fontSize: 20,
          height: 1.3,
          fontWeight: FontWeight.w600,
        ),
        body: TextStyle(fontSize: 16, height: 1.4),
        caption: TextStyle(fontSize: 14, height: 1.3),
        label: TextStyle(
          fontSize: 12,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Colors used throughout Sketchy widgets.
  final SketchyColors colors;

  /// Typography styles used for text rendering.
  final SketchyTypographyData typography;

  /// Default stroke width for drawn outlines.
  final double strokeWidth;

  /// Default border radius for card-like widgets.
  final double borderRadius;

  /// Returns a new theme with the provided overrides.
  SketchyThemeData copyWith({
    SketchyColors? colors,
    SketchyTypographyData? typography,
    double? strokeWidth,
    double? borderRadius,
  }) => SketchyThemeData(
    colors: colors ?? this.colors,
    typography: typography ?? this.typography,
    strokeWidth: strokeWidth ?? this.strokeWidth,
    borderRadius: borderRadius ?? this.borderRadius,
  );
}

/// Inherited widget wiring [SketchyThemeData] into the tree.
class SketchyTheme extends InheritedWidget {
  /// Creates a [SketchyTheme] that exposes [data] to descendants.
  const SketchyTheme({required this.data, required super.child, super.key});

  /// Active theme data.
  final SketchyThemeData data;

  /// Returns the nearest [SketchyThemeData] from the widget tree.
  static SketchyThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<SketchyTheme>();
    if (theme == null) {
      throw FlutterError(
        'No SketchyTheme found in context. Wrap your app with SketchyApp '
        'or SketchyTheme.',
      );
    }
    return theme.data;
  }

  @override
  bool updateShouldNotify(SketchyTheme oldWidget) => data != oldWidget.data;
}
