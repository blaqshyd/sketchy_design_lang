import 'package:flutter/widgets.dart';

import 'sketchy_theme.dart';

const _defaultFontFamily = 'ComicShanns';
const _defaultFontPackage = 'sketchy_design_lang';

/// Collection of text styles used throughout the Sketchy widgets.
class SketchyTypographyData {
  /// Creates a typography config with the provided text styles.
  const SketchyTypographyData({
    required this.headline,
    required this.title,
    required this.body,
    required this.caption,
    required this.label,
  });

  /// Comic Shanns-powered defaults.
  factory SketchyTypographyData.comicShanns() => const SketchyTypographyData(
    headline: TextStyle(
      fontFamily: _defaultFontFamily,
      package: _defaultFontPackage,
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w700,
    ),
    title: TextStyle(
      fontFamily: _defaultFontFamily,
      package: _defaultFontPackage,
      fontSize: 20,
      height: 1.3,
      fontWeight: FontWeight.w600,
    ),
    body: TextStyle(
      fontFamily: _defaultFontFamily,
      package: _defaultFontPackage,
      fontSize: 16,
      height: 1.4,
    ),
    caption: TextStyle(
      fontFamily: _defaultFontFamily,
      package: _defaultFontPackage,
      fontSize: 14,
      height: 1.3,
    ),
    label: TextStyle(
      fontFamily: _defaultFontFamily,
      package: _defaultFontPackage,
      fontSize: 12,
      height: 1.2,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Style used for large headings.
  final TextStyle headline;

  /// Style used for card titles and section headers.
  final TextStyle title;

  /// Default body style.
  final TextStyle body;

  /// Secondary text style.
  final TextStyle caption;

  /// Small label style (badge text, etc.).
  final TextStyle label;

  /// Returns a version with the provided overrides.
  SketchyTypographyData copyWith({
    TextStyle? headline,
    TextStyle? title,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? label,
  }) => SketchyTypographyData(
    headline: headline ?? this.headline,
    title: title ?? this.title,
    body: body ?? this.body,
    caption: caption ?? this.caption,
    label: label ?? this.label,
  );

  /// Returns a copy with each style merged with [other].
  SketchyTypographyData merge(SketchyTypographyData? other) {
    if (other == null) return this;
    return SketchyTypographyData(
      headline: headline.merge(other.headline),
      title: title.merge(other.title),
      body: body.merge(other.body),
      caption: caption.merge(other.caption),
      label: label.merge(other.label),
    );
  }
}

/// Helper to access the active [SketchyTypographyData].
class SketchyTypography {
  /// Looks up typography via the nearest [SketchyTheme].
  static SketchyTypographyData of(BuildContext context) =>
      SketchyTheme.of(context).typography;
}
