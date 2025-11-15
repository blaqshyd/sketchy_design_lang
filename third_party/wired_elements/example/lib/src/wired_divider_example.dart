import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates the wired divider widget.
class WiredDividerExample extends StatelessWidget {
  /// Creates the divider example.
  const WiredDividerExample({required this.title, super.key});

  /// Title shown in the app bar.
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(title, fontSize: 20)),
    body: Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      color: Colors.white,
      child: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WiredText(
              '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in 
culpa qui officia deserunt mollit anim id est laborum.
''',
              fontSize: 18,
              color: Colors.blueGrey,
            ),
            SizedBox(height: 15),
            WiredDivider(),
            WiredText(
              '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor 
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis 
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu 
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in 
culpa qui officia deserunt mollit anim id est laborum.
''',
              fontSize: 18,
              color: Colors.blueGrey,
            ),
          ],
        ),
      ),
    ),
  );
}
