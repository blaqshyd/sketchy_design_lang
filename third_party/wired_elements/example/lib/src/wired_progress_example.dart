import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wired_elements/wired_elements.dart';

import 'wired_text.dart';

/// Demonstrates the wired progress indicator.
class WiredProgressExample extends StatefulWidget {
  /// Creates the progress example.
  const WiredProgressExample({required this.title, super.key});

  /// Title shown in the app bar.
  final String title;

  @override
  WiredProgressExampleState createState() => WiredProgressExampleState();
}

/// State backing [WiredProgressExample].
class WiredProgressExampleState extends State<WiredProgressExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller1;
  late final AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: WiredText(widget.title, fontSize: 20)),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WiredProgress(controller: _controller1, value: 0.5),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [..._example(_controller1)],
          ),
          const SizedBox(height: 50),
          WiredProgress(controller: _controller2),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [..._example(_controller2)],
          ),
        ],
      ),
    ),
  );

  List<Widget> _example(AnimationController controller) => [
    WiredButton(
      child: const Text('Start'),
      onPressed: () {
        unawaited(controller.forward());
      },
    ),
    const SizedBox(width: 20),
    WiredButton(
      child: const Text('Stop'),
      onPressed: () {
        controller.stop();
      },
    ),
    const SizedBox(width: 20),
    WiredButton(
      child: const Text('Reset'),
      onPressed: () {
        controller.reset();
      },
    ),
  ];
}
