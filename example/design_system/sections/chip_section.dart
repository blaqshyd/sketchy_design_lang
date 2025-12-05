import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sketchy_design_lang/sketchy_design_lang.dart';

import '../theme/text_styles.dart';
import '../widgets/section_card.dart';

class ChipSection extends StatefulWidget {
  const ChipSection({super.key});

  @override
  State<ChipSection> createState() => _ChipSectionState();
}

class _ChipSectionState extends State<ChipSection> {
  bool _pinnedChip = true;
  bool _snoozedChip = false;
  bool _archiveChip = true;
  bool _iconOnlyChip = false;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => SectionCard(
      title: 'Sketchy chips',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _ChipGallery(
                  theme: theme,
                  title: 'Chip',
                  chips: [
                    const SketchyChip(
                      label: SketchyText('New drop'),
                      compact: true,
                      tone: SketchyChipTone.neutral,
                    ),
                    SketchyChip(
                      label: const SketchyText('Shipped!'),
                      compact: true,
                      backgroundColor: theme.primaryColor.withValues(
                        alpha: 0.35,
                      ),
                      tone: SketchyChipTone.accent,
                    ),
                    SketchyChip(
                      label: const SketchyText(''),
                      compact: true,
                      backgroundColor: theme.primaryColor.withValues(
                        alpha: 0.35,
                      ),
                      tone: SketchyChipTone.accent,
                      avatar: const FaIcon(FontAwesomeIcons.check),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ChipGallery(
                  theme: theme,
                  title: 'Choice',
                  chips: [
                    SketchyChoiceChip(
                      label: const SketchyText('Pinned'),
                      selected: _pinnedChip,
                      onSelected: (val) => setState(() => _pinnedChip = val),
                    ),
                    SketchyChoiceChip(
                      label: const SketchyText('Snooze'),
                      selected: _snoozedChip,
                      onSelected: (val) => setState(() => _snoozedChip = val),
                    ),
                    SketchyChoiceChip(
                      label: const SketchyText('Archive'),
                      selected: _archiveChip,
                      avatar: const FaIcon(FontAwesomeIcons.square),
                      onSelected: (val) => setState(() => _archiveChip = val),
                    ),
                    SketchyChoiceChip(
                      label: const SketchyText(''),
                      selected: _iconOnlyChip,
                      avatar: const FaIcon(FontAwesomeIcons.paperPlane),
                      onSelected: (val) => setState(() => _iconOnlyChip = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ChipGallery(
                  theme: theme,
                  title: 'Badge',
                  chips: [
                    SketchyChip(
                      label: const SketchyText('Beta'),
                      compact: true,
                      tone: SketchyChipTone.accent,
                      backgroundColor: theme.primaryColor.withValues(
                        alpha: 0.2,
                      ),
                    ),
                    SketchyChip(
                      label: const SketchyText('Muted'),
                      compact: true,
                      tone: SketchyChipTone.neutral,
                      backgroundColor: theme.paperColor,
                    ),
                    const SketchyChip(
                      label: SketchyText('Beta tag'),
                      compact: true,
                      tone: SketchyChipTone.accent,
                      avatar: FaIcon(FontAwesomeIcons.pen),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _ChipGallery(
                  theme: theme,
                  title: 'Suggestion',
                  chips: [
                    SketchyActionChip(
                      label: const SketchyText('#sketchythings'),
                      onPressed: () {},
                      tone: SketchyChipTone.neutral,
                    ),
                    SketchyActionChip(
                      label: const SketchyText('Palette'),
                      onPressed: () {},
                      tone: SketchyChipTone.accent,
                    ),
                    SketchyActionChip(
                      label: const SketchyText(''),
                      onPressed: () {},
                      tone: SketchyChipTone.accent,
                      avatar: const FaIcon(FontAwesomeIcons.plus),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class _ChipGallery extends StatelessWidget {
  const _ChipGallery({
    required this.theme,
    required this.title,
    required this.chips,
  });

  final SketchyThemeData theme;
  final String title;
  final List<Widget> chips;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SketchyText(title, style: fieldLabelStyle(theme)),
      const SizedBox(height: 8),
      Wrap(spacing: 12, runSpacing: 8, children: chips),
    ],
  );
}
