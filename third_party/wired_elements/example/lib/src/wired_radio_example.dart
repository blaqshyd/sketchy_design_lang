import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates wired radio buttons.
class WiredRadioExample extends StatefulWidget {
  /// Creates the radio example.
  const WiredRadioExample({required this.title, super.key});

  /// Title shown in the app bar.
  final String title;

  @override
  WiredRadioExampleState createState() => WiredRadioExampleState();
}

/// State backing [WiredRadioExample].
class WiredRadioExampleState extends State<WiredRadioExample> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(widget.title, fontSize: 20)),
    body: Column(
      children: <Widget>[
        const SizedBox(height: 15),
        ListTile(
          title: const Text('Lafayette'),
          leading: WiredRadio<SingingCharacter>(
            value: SingingCharacter.lafayette,
            groupValue: _character,
            onChanged: (value) {
              debugPrint('$value');
              setState(() {
                _character = value;
              });

              return true;
            },
          ),
        ),
        ListTile(
          title: const Text('Thomas Jefferson'),
          leading: WiredRadio<SingingCharacter>(
            value: SingingCharacter.jefferson,
            groupValue: _character,
            onChanged: (value) {
              debugPrint('$value');
              setState(() {
                _character = value;
              });

              return true;
            },
          ),
        ),
      ],
    ),
  );
}

/// People referenced in the radio example.
enum SingingCharacter {
  /// Lafayette option.
  lafayette,

  /// Jefferson option.
  jefferson,
}
