import 'package:flutter/widgets.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../theme/text_styles.dart';
import '../widgets/section_card.dart';

class ButtonsSection extends StatefulWidget {
  const ButtonsSection({super.key});

  @override
  State<ButtonsSection> createState() => _ButtonsSectionState();
}

class _ButtonsSectionState extends State<ButtonsSection> {
  bool _showFirst = false;
  bool _showSubmit = false;
  bool _showCancel = false;
  bool _showLong = false;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => SectionCard(
      title: 'Sketchy buttons',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SketchyButton(
                child: SketchyText(
                  'Sketchy Button',
                  style: buttonLabelStyle(theme),
                ),
                onPressed: () => setState(() => _showFirst = !_showFirst),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Opacity(
                  opacity: _showFirst ? 1.0 : 0.0,
                  child: SketchyText(
                    '<- Sketchy button',
                    style: mutedStyle(theme),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SketchyButton(
                child: SketchyText(
                  'Submit',
                  style: buttonLabelStyle(theme, color: theme.primaryColor),
                ),
                onPressed: () => setState(() => _showSubmit = !_showSubmit),
              ),
              const SizedBox(width: 12),
              SketchyButton(
                child: SketchyText(
                  'Cancel',
                  style: buttonLabelStyle(
                    theme,
                    color: const Color(0xFF9E9E9E),
                  ),
                ),
                onPressed: () => setState(() => _showCancel = !_showCancel),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: [
                    Opacity(
                      opacity: _showSubmit ? 1.0 : 0.0,
                      child: SketchyText('<- Submit', style: mutedStyle(theme)),
                    ),
                    const SizedBox(width: 12),
                    Opacity(
                      opacity: _showCancel ? 1.0 : 0.0,
                      child: SketchyText('<- Cancel', style: mutedStyle(theme)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SketchyButton(
                child: SketchyText(
                  'Long text button … hah',
                  style: buttonLabelStyle(theme),
                ),
                onPressed: () => setState(() => _showLong = !_showLong),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Opacity(
                  opacity: _showLong ? 1.0 : 0.0,
                  child: SketchyText('<- Long', style: mutedStyle(theme)),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
