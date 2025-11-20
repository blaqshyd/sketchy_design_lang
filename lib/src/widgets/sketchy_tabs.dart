import 'package:flutter/widgets.dart';

import '../primitives/sketchy_primitives.dart';
import '../theme/sketchy_text_case.dart';
import '../theme/sketchy_theme.dart';
import 'sketchy_surface.dart';
import 'sketchy_text.dart';

/// Segmented control used to switch between sections.
class SketchyTabs extends StatelessWidget {
  /// Creates a new tab bar with the provided labels.
  const SketchyTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    this.textCase,
    this.detachSelected = false,
    this.detachGap = 4,
    this.backgroundColor,
    this.eraseSelectedBorder = false,
    super.key,
  });

  /// Tab labels.
  final List<String> tabs;

  /// Currently selected tab index.
  final int selectedIndex;

  /// Callback invoked when a tab is selected.
  final ValueChanged<int> onChanged;

  /// Text casing transformation. If null, uses theTextCasing
  final TextCase? textCase;

  /// When true, reserves [detachGap] below the active tab to reveal the
  /// background color (useful for overlapping containers).
  final bool detachSelected;

  /// Height of the gap rendered when [detachSelected] is true.
  final double detachGap;

  /// Background color painted in the detached gap.
  final Color? backgroundColor;

  /// Paints over the active tab's bottom border so it blends with the
  /// container underneath.
  final bool eraseSelectedBorder;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => Row(
      children: [
        for (var i = 0; i < tabs.length; i++) ...[
          GestureDetector(
            onTap: () => onChanged(i),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabSurface(theme, i),
                  if (detachSelected && detachGap > 0)
                    SizedBox(
                      height: detachGap,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: i == selectedIndex
                              ? backgroundColor ?? theme.paperColor
                              : const Color(0x00000000),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ],
    ),
  );

  Widget _buildTabSurface(SketchyThemeData theme, int i) {
    final isSelected = i == selectedIndex;
    SketchyPrimitive primitiveBuilder() => SketchyPrimitive.rectangle(
      fill: isSelected ? SketchyFill.solid : SketchyFill.none,
    );

    Widget surface = SketchySurface(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      fillColor: isSelected ? theme.secondaryColor : theme.paperColor,
      strokeColor: theme.inkColor,
      createPrimitive: primitiveBuilder,
      child: SketchyText(
        tabs[i],
        textCase: textCase,
        style: theme.typography.body.copyWith(
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.normal,
        ),
      ),
    );

    if (eraseSelectedBorder && isSelected) {
      surface = Stack(
        clipBehavior: Clip.none,
        children: [
          surface,
          Positioned(
            left: 0,
            right: 0,
            bottom: -theme.strokeWidth,
            child: SizedBox(
              height: theme.strokeWidth,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundColor ?? theme.paperColor,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return surface;
  }
}
