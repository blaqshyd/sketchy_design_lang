import 'package:flutter/material.dart';

import 'home_page.dart';

/// Entry point for the wired_elements example app.
void main() {
  runApp(const MyApp());
}

/// Basic Material app that hosts the wired_elements demos.
class MyApp extends StatelessWidget {
  /// Creates the demo host widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomePage(),
  );
}
