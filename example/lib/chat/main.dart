import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import 'pages/chat_page.dart';

void main() {
  runApp(const ElizaChatApp());
}

/// The Eliza Chat example application - a virtual therapist experience.
class ElizaChatApp extends StatelessWidget {
  /// Creates the Eliza Chat app.
  const ElizaChatApp({super.key});

  @override
  Widget build(BuildContext context) => SketchyApp(
    title: 'Eliza Chat',
    theme: SketchyThemeData(
      inkColor: SketchyColors.sepia,
      paperColor: SketchyColors.parchment,
      primaryColor: SketchyColors.chatLavender,
      secondaryColor: SketchyColors.chatSage,
    ),
    home: const ChatPage(),
    debugShowCheckedModeBanner: false,
  );
}
