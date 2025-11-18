// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import '../theme/sketchy_theme.dart';
import '../widgets/sketchy_frame.dart';

/// Wired input.
///
/// Usage:
/// ```dart
/// SketchyTextInput(
///   controller: controller1,
///   style: TextStyle(
/// 	fontFamily: handWriting2,
/// 	fontSize: 18.0,
///   ),
///   labelText: 'Name',
///   labelStyle: TextStyle(
/// 	fontFamily: handWriting2,
/// 	fontSize: 18.0,
///   ),
/// ),
/// ```
class SketchyTextInput extends StatelessWidget {
  const SketchyTextInput({
    super.key,
    this.controller,
    this.style,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.onChanged,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// The text style for input.
  final TextStyle? style;

  /// Text that describes the input field.
  final String? labelText;

  /// The style to use for the [labelText] when the label is above (i.e.,
  /// vertically adjacent to) the input field.
  final TextStyle? labelStyle;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// The style to use for the [hintText].
  final TextStyle? hintStyle;

  /// Called when the text changes.
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final effectiveLabelStyle =
        labelStyle ??
        TextStyle(fontFamily: theme.fontFamily, color: theme.textColor);
    final effectiveStyle =
        style ??
        TextStyle(fontFamily: theme.fontFamily, color: theme.textColor);
    final effectiveHintStyle =
        hintStyle ??
        TextStyle(fontFamily: theme.fontFamily, color: theme.disabledTextColor);
    return Row(
      children: [
        if (labelText != null) Text('$labelText', style: effectiveLabelStyle),
        if (labelText != null) const SizedBox(width: 10),
        Expanded(
          child: SketchyFrame(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            fill: SketchyFill.none,
            child: Center(
              child: TextField(
                controller: controller,
                style: effectiveStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: effectiveHintStyle,
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
