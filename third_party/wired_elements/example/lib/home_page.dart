import 'package:flutter/material.dart';

import 'demos.dart';
import 'src/wired_text.dart';

/// Landing page listing all wired_elements demos.
class HomePage extends StatelessWidget {
  /// Creates the top-level home page.
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const WiredText('Flutter wired_elements example', fontSize: 20),
    ),
    body: const DemoList(),
  );
}

/// Scrollable list of demo rows.
class DemoList extends StatelessWidget {
  /// Creates the demo list widget.
  const DemoList({super.key});

  @override
  Widget build(BuildContext context) => ListView.separated(
    separatorBuilder: (context, position) => ColoredBox(
      color: Theme.of(context).cardColor,
      child: const Divider(indent: 64, thickness: 1, height: 4),
    ),
    itemCount: demos.length,
    itemBuilder: (context, position) => DemoRow(demo: demos[position]),
  );
}

/// One row describing a demo entry.
class DemoRow extends StatelessWidget {
  /// Creates a row for the supplied [demo].
  const DemoRow({required this.demo, super.key});

  /// Demo metadata that drives this row.
  final Demo demo;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Theme.of(context).cardColor,
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      title: WiredText(demo.name, fontSize: 20),
      dense: false,
      subtitle: WiredText(demo.description, fontSize: 16),
      leading: SizedBox(width: 42, height: 42, child: demo.icon),
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: demo.buildPage)),
    ),
  );
}
