// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import '../widgets/sketchy_frame.dart';

/// Wired divider.
///
/// Usage:
/// ```dart
/// WiredText(
/// 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
/// fontSize: 18.0,
/// color: Colors.blueGrey,
/// ),
/// SizedBox(height: 15.0),
/// SketchyDivider(),
/// WiredText(
/// 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
/// fontSize: 18.0,
/// color: Colors.blueGrey,
/// ),
/// ```
class SketchyDivider extends StatelessWidget {
  const SketchyDivider({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
    height: 16,
    child: Center(
      child: SketchyFrame(
        height: 2,
        fill: SketchyFill.none,
        child: SizedBox.expand(),
      ),
    ),
  );
}
