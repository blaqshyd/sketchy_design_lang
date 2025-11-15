import 'package:flutter/material.dart';

import '../rough/rough.dart';
import 'const.dart';
import 'wired_base.dart';

/// Wired checkbox.
///
/// Usage:
/// ```dart
/// WiredCheckbox(
///   value: false,
///   onChanged: (value) {
/// 	print('Wired Checkbox $value');
///   },
/// ),
/// ```
class WiredCheckbox extends StatefulWidget {
  const WiredCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Determines the checkbox checked or not.
  final bool? value;

  /// Called once the checkbox check status changes.
  final void Function(bool?) onChanged;

  @override
  State<WiredCheckbox> createState() => _WiredCheckboxState();
}

class _WiredCheckboxState extends State<WiredCheckbox> with WiredRepaintMixin {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.value!;
  }

  @override
  Widget build(BuildContext context) =>
      buildWiredElement(key: widget.key, child: _buildWidget());

  Widget _buildWidget() => Container(
    padding: EdgeInsets.zero,
    height: 27,
    width: 27,
    decoration: const RoughBoxDecoration(
      shape: RoughBoxShape.rectangle,
      borderStyle: RoughDrawingStyle(width: 1, color: borderColor),
    ),
    child: SizedBox(
      height: double.infinity,
      child: Transform.scale(
        // Checkbox default size is 18.0, so 18.0 * 1.5 = 27 for the outer Container's width & height
        scale: 1.5,
        child: Checkbox(
          fillColor: WidgetStateProperty.all(Colors.transparent),
          checkColor: borderColor,
          onChanged: (value) {
            setState(() {
              widget.onChanged(value);
              _value = value!;
            });
          },
          value: _value,
        ),
      ),
    ),
  );
}
