import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Example showcasing the wired calendar widget.
class WiredCalendarExample extends StatefulWidget {
  /// Creates the calendar example screen.
  const WiredCalendarExample({required this.title, super.key});

  /// Title displayed in the app bar.
  final String title;

  @override
  WiredCalendarExampleState createState() => WiredCalendarExampleState();
}

/// State backing [WiredCalendarExample].
class WiredCalendarExampleState extends State<WiredCalendarExample> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(widget.title, fontSize: 20)),
    body: Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.all(15),
      height: 460,
      child: WiredCalendar(
        selected: '20210722',
        onSelected: (value) {
          debugPrint('Selected date: $value');
        },
      ),
    ),
  );
}
