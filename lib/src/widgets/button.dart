import 'package:flutter/widgets.dart';
import 'package:rough_flutter/rough_flutter.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Available button variants.
enum SketchyButtonVariant {
  /// Filled accent button.
  primary,

  /// Muted secondary button.
  secondary,

  /// Transparent ghost button.
  ghost,
}

/// Rough-styled button used throughout the Sketchy widget set.
class SketchyButton extends StatelessWidget {
  /// Shared private constructor for the named factories.
  const SketchyButton._({
    required this.label,
    required this.onPressed,
    required this.variant,
    super.key,
  });

  /// Creates a filled primary button.
  const SketchyButton.primary({
    required String label,
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: SketchyButtonVariant.primary,
       );

  /// Creates a secondary button with a muted fill.
  const SketchyButton.secondary({
    required String label,
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: SketchyButtonVariant.secondary,
       );

  /// Creates a ghost button with a transparent fill.
  const SketchyButton.ghost({
    required String label,
    Key? key,
    VoidCallback? onPressed,
  }) : this._(
         key: key,
         label: label,
         onPressed: onPressed,
         variant: SketchyButtonVariant.ghost,
       );

  /// Text rendered inside the button.
  final String label;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// Visual style applied to the button.
  final SketchyButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);
    final color = switch (variant) {
      SketchyButtonVariant.primary => theme.colors.paper,
      SketchyButtonVariant.secondary => theme.colors.ink,
      SketchyButtonVariant.ghost => theme.colors.ink,
    };
    final background = switch (variant) {
      SketchyButtonVariant.primary => theme.colors.accent,
      SketchyButtonVariant.secondary => theme.colors.accentMuted,
      SketchyButtonVariant.ghost => theme.colors.paper,
    };

    final button = Container(
      height: 48,
      alignment: Alignment.center,
      decoration: RoughBoxDecoration(
        borderStyle: RoughDrawingStyle(
          width: theme.strokeWidth,
          color: theme.colors.ink,
        ),
        fillStyle: RoughDrawingStyle(color: background),
      ),
      child: Text(
        label,
        style: typography.body.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (onPressed == null) {
      return Opacity(opacity: 0.4, child: IgnorePointer(child: button));
    }
    return GestureDetector(onTap: onPressed, child: button);
  }
}
