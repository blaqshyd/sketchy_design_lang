import 'package:flutter/material.dart';

import 'const.dart' as wired_const;

/// Theme configuration for wired widgets.
class WiredThemeData {
  const WiredThemeData({
    this.borderColor = wired_const.borderColor,
    this.fillColor = wired_const.filledColor,
    this.textColor = wired_const.textColor,
    this.disabledTextColor = wired_const.disabledTextColor,
    this.strokeWidth = 1.0,
    this.fontFamily = 'ComicShanns',
    this.roughness = 1.0,
  });

  final Color borderColor;
  final Color fillColor;
  final Color textColor;
  final Color disabledTextColor;
  final double strokeWidth;
  final String fontFamily;
  final double roughness;

  WiredThemeData copyWith({
    Color? borderColor,
    Color? fillColor,
    Color? textColor,
    Color? disabledTextColor,
    double? strokeWidth,
    String? fontFamily,
    double? roughness,
  }) => WiredThemeData(
    borderColor: borderColor ?? this.borderColor,
    fillColor: fillColor ?? this.fillColor,
    textColor: textColor ?? this.textColor,
    disabledTextColor: disabledTextColor ?? this.disabledTextColor,
    strokeWidth: strokeWidth ?? this.strokeWidth,
    fontFamily: fontFamily ?? this.fontFamily,
    roughness: roughness ?? this.roughness,
  );
}

/// Inherited theme hook for wired widgets.
class WiredTheme extends InheritedWidget {
  const WiredTheme({required this.data, required super.child, super.key});

  final WiredThemeData data;

  static WiredThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<WiredTheme>();
    return theme?.data ?? const WiredThemeData();
  }

  @override
  bool updateShouldNotify(WiredTheme oldWidget) => data != oldWidget.data;
}
