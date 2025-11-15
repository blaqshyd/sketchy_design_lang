import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates wired checkboxes.
class WiredCheckboxExample extends StatelessWidget {
  /// Creates the checkbox example.
  const WiredCheckboxExample({required this.title, super.key});

  /// Title shown in the app bar.
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(title, fontSize: 20)),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WiredCheckbox(
            value: false,
            onChanged: (value) {
              debugPrint('Wired Checkbox $value');
            },
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              WiredCheckbox(
                value: true,
                onChanged: (value) {
                  debugPrint('Labeled Wired Checkbox $value');
                },
              ),
              const SizedBox(width: 5),
              const WiredText('Terms & Privacy'),
            ],
          ),
        ],
      ),
    ),
  );
}
