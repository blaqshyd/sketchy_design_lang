import 'package:flutter/material.dart';
import '../../rough/rough.dart';
import '../wired_theme.dart';
import 'wired_painter_base.dart';

class WiredPainter extends CustomPainter {
  WiredPainter(this.drawConfig, this.filler, this.painter, this.theme);
  final DrawConfig drawConfig;
  final Filler filler;
  final WiredPainterBase painter;
  final WiredThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    drawConfig.randomizer!.reset();
    painter.paintRough(canvas, size, drawConfig, filler, theme);
  }

  @override
  bool shouldRepaint(WiredPainter oldDelegate) =>
      oldDelegate.drawConfig != drawConfig ||
      oldDelegate.theme != theme ||
      oldDelegate.filler != filler;
}
