import 'package:flutter/material.dart';

import '../demos.dart';

/// Text widget styled with the demo handwriting font.
class WiredText extends StatelessWidget {
  /// Creates a wired text widget.
  const WiredText(
    this.data, {
    super.key,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 18,
    this.color = Colors.black,
  });

  /// Text data to display.
  final String data;

  /// Font weight override.
  final FontWeight? fontWeight;

  /// Font size override.
  final double? fontSize;

  /// Color override.
  final Color? color;

  @override
  Widget build(BuildContext context) => Text(
    data,
    style: TextStyle(
      decoration: TextDecoration.none,
      fontFamily: handWriting2,
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
    ),
  );
}
