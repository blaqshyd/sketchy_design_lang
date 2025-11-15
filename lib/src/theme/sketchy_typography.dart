import 'package:flutter/widgets.dart';

import 'sketchy_theme.dart';

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
