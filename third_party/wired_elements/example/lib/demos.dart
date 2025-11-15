import 'package:flutter/material.dart';

import 'src/wired_button_example.dart';
import 'src/wired_calendar_example.dart';
import 'src/wired_card_example.dart';
import 'src/wired_checkbox_example.dart';
import 'src/wired_combo_example.dart';
import 'src/wired_dialog_example.dart';
import 'src/wired_divider_example.dart';
import 'src/wired_input_example.dart';
import 'src/wired_progress_example.dart';
import 'src/wired_radio_example.dart';
import 'src/wired_slider_example.dart';
import 'src/wired_toggle_example.dart';

/// Primary handwriting font used by the demos.
const String handWriting1 = 'Shadows Into Light';

/// Secondary handwriting font used by the demos.
const String handWriting2 = 'Architects Daughter';

/// Collection of demo configurations.
final List<Demo> demos = [
  NormalDemo(
    'Wired button example',
    'Wired button',
    (_) => const WiredButtonExample(title: 'Wired button example'),
    const Icon(Icons.touch_app, size: 36),
  ),
  NormalDemo(
    'Wired card example',
    'Wired card',
    (_) => const WiredCardExample(title: 'Wired card'),
    const Icon(Icons.dashboard, size: 36),
  ),
  NormalDemo(
    'Wired checkbox example',
    'Wired checkbox',
    (_) => const WiredCheckboxExample(title: 'Wired checkbox'),
    const Icon(Icons.check_box, size: 36),
  ),
  NormalDemo(
    'Wired combo example',
    'Wired combo',
    (_) => const WiredComboExample(title: 'Wired combo'),
    const Icon(Icons.arrow_drop_down, size: 36),
  ),
  NormalDemo(
    'Wired dialog example',
    'Wired dialog',
    (_) => const WiredDialogExample(title: 'Wired dialog'),
    const Icon(Icons.open_in_new, size: 36),
  ),
  NormalDemo(
    'Wired divider example',
    'Wired divider',
    (_) => const WiredDividerExample(title: 'Wired divider'),
    const Icon(Icons.horizontal_split, size: 36),
  ),
  NormalDemo(
    'Wired input example',
    'Wired input',
    (_) => const WiredInputExample(title: 'Wired input'),
    const Icon(Icons.keyboard, size: 36),
  ),
  NormalDemo(
    'Wired radio example',
    'Wired radio',
    (_) => const WiredRadioExample(title: 'Wired radio'),
    const Icon(Icons.radio_button_checked, size: 36),
  ),
  NormalDemo(
    'Wired slider example',
    'Wired slider',
    (_) => const WiredSliderExample(title: 'Wired slider'),
    const Icon(Icons.linear_scale, size: 36),
  ),
  NormalDemo(
    'Wired toggle example',
    'Wired toggle',
    (_) => const WiredToggleExample(title: 'Wired toggle'),
    const Icon(Icons.toggle_on, size: 36),
  ),
  NormalDemo(
    'Wired progress example',
    'Wired progress',
    (_) => const WiredProgressExample(title: 'Wired progress'),
    const Icon(Icons.portrait, size: 36),
  ),
  NormalDemo(
    'Wired calendar example',
    'Wired calendar',
    (_) => const WiredCalendarExample(title: 'Wired calendar'),
    const Icon(Icons.calendar_today, size: 36),
  ),
];

/// Base configuration shared by all demo types.
abstract class Demo {
  /// Creates a new demo configuration.
  Demo(this.name, this.description, this.icon);

  /// Display name for the demo.
  final String name;

  /// Short description used in the list.
  final String description;

  /// Icon rendered beside the description.
  final Widget icon;

  /// Builds the actual demo page.
  Widget buildPage(BuildContext context);
}

/// Simple demo backed by a [WidgetBuilder].
class NormalDemo extends Demo {
  /// Creates a demo backed by [builder].
  NormalDemo(String name, String description, this.builder, Widget icon)
    : super(name, description, icon);

  /// Builder invoked when opening the demo.
  final WidgetBuilder builder;

  @override
  Widget buildPage(BuildContext context) => builder(context);
}
