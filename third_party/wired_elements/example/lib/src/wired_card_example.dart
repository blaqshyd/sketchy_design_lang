import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates the wired card widget.
class WiredCardExample extends StatelessWidget {
  /// Creates the card example.
  const WiredCardExample({required this.title, super.key});

  /// Title displayed in the app bar.
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(title, fontSize: 20)),
    body: Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: WiredCard(
            height: 150,
            fill: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album),
                  title: WiredText('The Enchanted Nightingale'),
                  subtitle: WiredText(
                    'Music by Julie Gable. Lyrics by Sidney Stein.',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    WiredButton(
                      child: const WiredText('BUY TICKETS'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                    WiredButton(
                      child: const WiredText('LISTEN'),
                      onPressed: () {
                        /* ... */
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.all(10),
          color: Colors.blue.shade100,
          child: WiredCard(
            fill: true,
            height: 100,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                debugPrint('Card tapped.');
              },
              child: const SizedBox(
                width: 300,
                height: 100,
                child: WiredText('A card that can be tapped'),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
