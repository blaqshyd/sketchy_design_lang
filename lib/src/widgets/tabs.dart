import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Segmented control used to switch between sections.
class SketchyTabs extends StatelessWidget {
  /// Creates a new tab bar with the provided labels.
  const SketchyTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  /// Tab labels.
  final List<String> tabs;

  /// Currently selected tab index.
  final int selectedIndex;

  /// Callback invoked when a tab is selected.
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);

    return Row(
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: RoughBoxDecoration(
                borderStyle: RoughDrawingStyle(
                  width: theme.strokeWidth,
                  color: theme.colors.ink,
                ),
                fillStyle: RoughDrawingStyle(
                  color: i == selectedIndex
                      ? theme.colors.accentMuted
                      : theme.colors.paper,
                ),
              ),
              child: Text(
                tabs[i],
                style: typography.body.copyWith(
                  fontWeight: i == selectedIndex
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
