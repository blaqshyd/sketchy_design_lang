import 'package:flutter/widgets.dart';
import 'package:rough_notation/rough_notation.dart';

import '../theme/sketchy_theme.dart';
import '../theme/sketchy_typography.dart';

/// Annotation styles supported by [SketchyAnnotate].
enum SketchyAnnotationType {
  /// Draws a rough rectangle around the child.
  box,

  /// Draws a rough circle around the child.
  circle,

  /// Underlines the child with a rough stroke.
  underline,

  /// Highlights the child with a marker-like fill.
  highlight,
}

/// Widget that wraps [child] with RoughNotation effects.
class SketchyAnnotate extends StatelessWidget {
  /// Internal constructor shared by the named factories.
  const SketchyAnnotate._({
    required this.child,
    required this.type,
    super.key,
    this.label,
  });

  /// Draws a rough box around [child].
  const SketchyAnnotate.box({required Widget child, Key? key, String? label})
    : this._(
        key: key,
        child: child,
        type: SketchyAnnotationType.box,
        label: label,
      );

  /// Draws a rough circle around [child].
  const SketchyAnnotate.circle({required Widget child, Key? key, String? label})
    : this._(
        key: key,
        child: child,
        type: SketchyAnnotationType.circle,
        label: label,
      );

  /// Underlines [child] with a rough stroke.
  const SketchyAnnotate.underline({
    required Widget child,
    Key? key,
    String? label,
  }) : this._(
         key: key,
         child: child,
         type: SketchyAnnotationType.underline,
         label: label,
       );

  /// Highlights [child] with a rough fill.
  const SketchyAnnotate.highlight({
    required Widget child,
    Key? key,
    String? label,
  }) : this._(
         key: key,
         child: child,
         type: SketchyAnnotationType.highlight,
         label: label,
       );

  /// Widget being annotated.
  final Widget child;

  /// Optional label rendered below the annotation.
  final String? label;

  /// Annotation style to apply.
  final SketchyAnnotationType type;

  @override
  Widget build(BuildContext context) {
    final theme = SketchyTheme.of(context);
    final typography = SketchyTypography.of(context);
    final annotation = switch (type) {
      SketchyAnnotationType.box => RoughBoxAnnotation(
        color: theme.colors.accent.withValues(alpha: 0.3),
        child: child,
      ),
      SketchyAnnotationType.circle => RoughCircleAnnotation(
        color: theme.colors.info,
        child: child,
      ),
      SketchyAnnotationType.underline => RoughUnderlineAnnotation(
        color: theme.colors.accent,
        child: child,
      ),
      SketchyAnnotationType.highlight => RoughHighlightAnnotation(
        color: theme.colors.accentMuted,
        child: child,
      ),
    };

    if (label == null) return annotation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        annotation,
        const SizedBox(height: 4),
        Text(
          label!,
          style: typography.caption.copyWith(
            color: theme.colors.ink.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
