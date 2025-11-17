import 'package:flutter/material.dart';

import '../rough/rough.dart';
import 'canvas/wired_canvas.dart';
import 'wired_base.dart';
import 'wired_theme.dart';

/// Wired radio.
///
/// Usage:
/// ```dart
/// ListTile(
/// title: const Text('Lafayette'),
/// leading: WiredRadio<SingingCharacter>(
///   value: SingingCharacter.lafayette,
///   groupValue: _character,
///   onChanged: (SingingCharacter? value) {
/// 	print('$value');
/// 	setState(() {
/// 	  _character = value;
/// 	});
///
/// 	return true;
///   },
/// ),
/// ),
/// ```
class WiredRadio<T> extends StatefulWidget {
  const WiredRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  /// The value for radio.
  final T value;

  /// The current group radios value.
  final T? groupValue;

  /// Called when the radio value changes.
  final bool Function(T?)? onChanged;

  @override
  _WiredRadioState<T> createState() => _WiredRadioState<T>();
}

class _WiredRadioState<T> extends State<WiredRadio<T>> {
  bool _isSelected = false;
  T? _groupValue;

  @override
  Widget build(BuildContext context) {
    _groupValue = widget.groupValue;
    _isSelected = _groupValue == widget.value;
    final theme = WiredTheme.of(context);
    return SizedBox(
      height: 48,
      width: 48,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _handleTap,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                height: 48,
                width: 48,
                child: WiredCanvas(
                  painter: WiredCircleBase(
                    diameterRatio: .7,
                    strokeColor: theme.borderColor,
                  ),
                  fillerType: RoughFilter.NoFiller,
                ),
              ),
            ),
            if (_isSelected)
              Positioned(
                left: 12,
                top: 12,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: WiredCanvas(
                    painter: WiredCircleBase(
                      diameterRatio: .7,
                      fillColor: theme.textColor,
                      strokeColor: theme.textColor,
                    ),
                    fillerType: RoughFilter.HachureFiller,
                    fillerConfig: FillerConfig.build(hachureGap: 1),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _handleTap() {
    if (widget.onChanged == null) return;
    final selected = widget.onChanged!(widget.value);
    if (!mounted) return;
    setState(() {
      _isSelected = selected;
      if (selected) {
        _groupValue = widget.value;
      }
    });
  }
}
