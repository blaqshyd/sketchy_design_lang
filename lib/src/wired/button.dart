// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../theme/sketchy_theme.dart';
import '../widgets/sketchy_frame.dart';

class SketchyButton extends StatelessWidget {
  const SketchyButton({required this.child, this.onPressed, super.key});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    return SketchyFrame(
      height: 42,
      padding: EdgeInsets.zero,
      strokeColor: theme.borderColor,
      strokeWidth: theme.strokeWidth,
      fill: SketchyFill.none,
      child: SizedBox(
        height: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.textColor,
            disabledForegroundColor: theme.disabledTextColor,
            textStyle: TextStyle(fontFamily: theme.fontFamily),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
          onPressed: onPressed,
          child: Align(alignment: Alignment.center, child: child),
        ),
      ),
    );
  }
}
