import 'package:flutter/material.dart';
import '../rough/rough.dart';

import 'const.dart';
import 'wired_base.dart';

/// Wired button.
///
/// Usage:
/// ```dart
/// WiredButton(
///  child: WiredText('Wired Button'),
///  onPressed: () {
///   print('Wired Button');
///  },
/// ),
/// ```
class WiredButton extends WiredBaseWidget {
  const WiredButton({required this.child, required this.onPressed, Key? key})
    : super(key: key);

  /// Typically the button's label.
  final Widget child;

  /// Called when the button is tapped
  final void Function() onPressed;

  @override
  Widget buildWiredElement() => Container(
    padding: EdgeInsets.zero,
    height: 42,
    decoration: const RoughBoxDecoration(
      shape: RoughBoxShape.rectangle,
      borderStyle: RoughDrawingStyle(width: 1, color: borderColor),
    ),
    child: SizedBox(
      height: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(foregroundColor: textColor),
        onPressed: onPressed,
        child: child,
      ),
    ),
  );
}
