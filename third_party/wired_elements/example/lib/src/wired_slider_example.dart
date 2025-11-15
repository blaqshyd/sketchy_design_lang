import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates the wired slider widget.
class WiredSliderExample extends StatefulWidget {
  /// Creates the slider example.
  const WiredSliderExample({required this.title, super.key});

  /// Title shown in the app bar.
  final String title;

  @override
  WiredSliderExampleState createState() => WiredSliderExampleState();
}

/// State backing [WiredSliderExample].
class WiredSliderExampleState extends State<WiredSliderExample> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(widget.title, fontSize: 20)),
    body: Container(
      padding: const EdgeInsets.all(25),
      height: 200,
      child: WiredSlider(
        value: _currentSliderValue,
        min: 0,
        max: 100,
        divisions: 5,
        label: _currentSliderValue.round().toString(),
        onChanged: (value) {
          setState(() {
            _currentSliderValue = value;
          });
          debugPrint('$_currentSliderValue');
          return true;
        },
      ),
    ),
  );
}
