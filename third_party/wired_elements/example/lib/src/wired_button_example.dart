import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates the wired button widget.
class WiredButtonExample extends StatelessWidget {
  /// Creates the wired button example screen.
  const WiredButtonExample({required this.title, super.key});

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
          WiredButton(
            child: const WiredText('Wired Button'),
            onPressed: () => debugPrint('Wired Button'),
          ),
          const SizedBox(height: 50),
          WiredButton(
            child: const WiredText('Submit'),
            onPressed: () => debugPrint('Submit'),
          ),
          const SizedBox(height: 50),
          WiredButton(
            child: const WiredText('Cancel'),
            onPressed: () => debugPrint('Cancel'),
          ),
          const SizedBox(height: 50),
          WiredButton(
            child: const WiredText('Long text button ...... hah'),
            onPressed: () => debugPrint('Long text button ...... hah'),
          ),
        ],
      ),
    ),
  );
}
