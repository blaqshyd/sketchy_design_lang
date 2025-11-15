import 'package:flutter/widgets.dart';

/// Lightweight fade transition used throughout Sketchy navigation.
class SketchyPageRoute<T> extends PageRouteBuilder<T> {
  /// Creates a page route that fades between pages.
  SketchyPageRoute({required WidgetBuilder builder, super.settings})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
              child: child,
            ),
      );
}
