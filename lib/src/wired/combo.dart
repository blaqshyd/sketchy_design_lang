// ignore_for_file: public_member_api_docs
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../widgets/icons.dart';
import '../widgets/sketchy_frame.dart';

/// Wired combo
///
/// Usage:
/// ```dart
/// SketchyCombo(
///   value: 'One',
///   items: ['One', 'Two', 'Free', 'Four']
/// 	  .map<DropdownMenuItem<String>>((dynamic value) {
/// 	return DropdownMenuItem<String>(
/// 	  value: value,
/// 	  child: Padding(
/// 		padding: EdgeInsets.only(left: 5.0),
/// 		child: WiredText(value),
/// 	  ),
/// 	);
///   }).toList(),
///   onChanged: (value) {
/// 	print('$value');
///   },
/// ),
/// ```
class SketchyCombo extends StatefulWidget {
  const SketchyCombo({
    required this.items,
    super.key,
    this.value,
    this.onChanged,
  });

  /// The selected value for combo.
  final dynamic value;

  /// The selection items for combo.
  final List<DropdownMenuItem<dynamic>> items;

  /// Called when the combo selected value changed.
  final Function(dynamic)? onChanged;

  @override
  State<SketchyCombo> createState() => _SketchyComboState();
}

class _SketchyComboState extends State<SketchyCombo> {
  final double _height = 56;
  dynamic _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: _height,
    child: Stack(
      children: [
        SketchyFrame(
          height: _height,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          fill: SketchyFill.none,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: _value,
              isExpanded: true,
              elevation: 0,
              icon: const SizedBox.shrink(),
              items: widget.items,
              onChanged: (dynamic value) {
                setState(() {
                  _value = value;
                });
                widget.onChanged?.call(_value);
              },
            ),
          ),
        ),
        Positioned(
          right: 12,
          top: (_height - 20) / 2,
          child: Transform.rotate(
            angle: math.pi / 2,
            child: const SketchyIcon(icon: SketchyIcons.chevronRight),
          ),
        ),
      ],
    ),
  );
}
