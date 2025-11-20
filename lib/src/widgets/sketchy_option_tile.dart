import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';
import 'sketchy_checkbox.dart';
import 'sketchy_radio.dart';

enum _SketchyOptionTileType { checkbox, radio }

/// Generic tile that wires a Sketchy checkbox or radio control with any label.
class SketchyOptionTile<T> extends StatelessWidget {
  /// Creates a tile wrapping a [SketchyCheckbox].
  const SketchyOptionTile.checkbox({
    required this.label,
    required bool value,
    required ValueChanged<bool?>? onChanged,
    this.helper,
    super.key,
  }) : _type = _SketchyOptionTileType.checkbox,
       checkboxValue = value,
       onCheckboxChanged = onChanged,
       radioValue = null,
       radioGroupValue = null,
       onRadioChanged = null;

  /// Creates a tile wrapping a [SketchyRadio].
  const SketchyOptionTile.radio({
    required this.label,
    required T value,
    required T groupValue,
    required ValueChanged<T?>? onChanged,
    this.helper,
    super.key,
  }) : _type = _SketchyOptionTileType.radio,
       checkboxValue = null,
       onCheckboxChanged = null,
       radioValue = value,
       radioGroupValue = groupValue,
       onRadioChanged = onChanged;

  final _SketchyOptionTileType _type;

  /// Widget rendered as the main label for the control.
  final Widget label;

  /// Optional helper widget displayed beneath [label].
  final Widget? helper;

  /// Current value when the tile is configured as a checkbox.
  final bool? checkboxValue;

  /// Callback fired when the checkbox changes state.
  final ValueChanged<bool?>? onCheckboxChanged;

  /// Currently selected radio group value.
  final T? radioGroupValue;

  /// Value represented by this radio tile.
  final T? radioValue;

  /// Callback fired when the radio tile is selected.
  final ValueChanged<T?>? onRadioChanged;

  bool get _isEnabled => _type == _SketchyOptionTileType.checkbox
      ? onCheckboxChanged != null
      : onRadioChanged != null;

  void _handleTap() {
    if (!_isEnabled) return;
    switch (_type) {
      case _SketchyOptionTileType.checkbox:
        onCheckboxChanged?.call(!(checkboxValue ?? false));
      case _SketchyOptionTileType.radio:
        onRadioChanged?.call(radioValue);
    }
  }

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) {
      final control = _type == _SketchyOptionTileType.checkbox
          ? SketchyCheckbox(
              value: checkboxValue ?? false,
              onChanged: (val) => onCheckboxChanged?.call(val),
            )
          : SketchyRadio<T>(
              value: radioValue as T,
              groupValue: radioGroupValue,
              onChanged: onRadioChanged,
            );

      final labelColumn = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          if (helper != null) ...[const SizedBox(height: 4), helper!],
        ],
      );

      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _isEnabled ? _handleTap : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            control,
            const SizedBox(width: 12),
            Expanded(child: labelColumn),
          ],
        ),
      );
    },
  );
}
