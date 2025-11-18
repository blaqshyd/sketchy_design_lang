// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import '../theme/sketchy_theme.dart';
import '../widgets/sketchy_frame.dart';

class SketchySlider extends StatefulWidget {
  const SketchySlider({
    required this.value,
    required this.onChanged,
    super.key,
    this.divisions,
    this.label,
    this.min = 0.0,
    this.max = 1.0,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final int? divisions;
  final String? label;
  final double min;
  final double max;

  @override
  State<SketchySlider> createState() => _SketchySliderState();
}

class _SketchySliderState extends State<SketchySlider> {
  double _currentSliderValue = 0;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    return SizedBox(
      height: 48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const knobSize = 24.0;
          final trackWidth = (constraints.maxWidth - knobSize).clamp(
            0.0,
            double.infinity,
          );
          final range = (widget.max - widget.min).abs();
          final normalized = range == 0
              ? 0.0
              : ((_currentSliderValue - widget.min) / range).clamp(0.0, 1.0);
          final knobLeft = trackWidth * normalized;

          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: knobSize / 2),
                child: SketchyFrame(
                  height: theme.strokeWidth,
                  fill: SketchyFill.none,
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned(
                left: knobLeft,
                top: (constraints.maxHeight - knobSize) / 2,
                child: SketchyFrame(
                  width: knobSize,
                  height: knobSize,
                  shape: SketchyFrameShape.circle,
                  fill: SketchyFill.solid,
                  fillColor: theme.colors.ink,
                  child: const SizedBox.expand(),
                ),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 0,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  ),
                ),
                child: Slider(
                  value: _currentSliderValue,
                  min: widget.min,
                  max: widget.max,
                  divisions: widget.divisions,
                  label: widget.label,
                  activeColor: Colors.transparent,
                  inactiveColor: Colors.transparent,
                  onChanged: (value) {
                    widget.onChanged?.call(value);
                    setState(() => _currentSliderValue = value);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
