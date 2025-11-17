import 'dart:ui';

import '../../rough/rough.dart';
import '../wired_theme.dart';

abstract class WiredPainterBase {
  void paintRough(
    Canvas canvas,
    Size size,
    DrawConfig drawConfig,
    Filler filler,
    WiredThemeData theme,
  );
}
