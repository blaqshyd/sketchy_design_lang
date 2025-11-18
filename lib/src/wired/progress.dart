// ignore_for_file: public_member_api_docs
import 'package:flutter/material.dart';

import '../theme/sketchy_theme.dart';
import '../widgets/sketchy_frame.dart';

/// Wired progress
///
/// Usage:
/// ```dart
/// final _controller = AnimationController(
///    duration: const Duration(milliseconds: 1000), vsync: this);
/// ......
/// SketchyProgressBar(controller: _controller, value: 0.5),
/// ......
/// _controller.forward();
/// _controller.stop();
/// _controller.reset();
/// ```
class SketchyProgressBar extends StatefulWidget {
  const SketchyProgressBar({this.controller, super.key, this.value = 0.0});

  /// The current progress value, range is 0.0 ~ 1.0.
  final double value;

  final AnimationController? controller;

  @override
  State<SketchyProgressBar> createState() => _SketchyProgressBarState();
}

class _SketchyProgressBarState extends State<SketchyProgressBar> {
  final double _progressHeight = 20;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleTick);
    // Delay for calculating `_getWidth()` during the next frame.
    Future.delayed(Duration.zero, () => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant SketchyProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTick);
      widget.controller?.addListener(_handleTick);
    }
    if (widget.controller == null && oldWidget.value != widget.value) {
      setState(() {});
    }
  }

  void _handleTick() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final progress = (widget.controller?.value ?? widget.value).clamp(0.0, 1.0);

    return SizedBox(
      height: _progressHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final filledWidth = width * progress;
          return Stack(
            children: [
              SketchyFrame(
                height: _progressHeight,
                fill: SketchyFill.none,
                child: const SizedBox.expand(),
              ),
              if (progress > 0)
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: filledWidth,
                    height: _progressHeight,
                    child: SketchyFrame(
                      height: _progressHeight,
                      fill: SketchyFill.hachure,
                      strokeWidth: 0,
                      fillColor: theme.colors.ink,
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTick);
    super.dispose();
  }
}
