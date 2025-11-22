import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';
import 'sketchy_app_bar.dart';

/// Minimal scaffold that avoids pulling in Material widgets.
class SketchyScaffold extends StatelessWidget {
  /// Creates a scaffold with optional [appBar], [body], and FAB.
  const SketchyScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  /// Optional Sketchy app bar.
  final SketchyAppBar? appBar;

  /// Primary body content.
  final Widget? body;

  /// Optional floating action button.
  final Widget? floatingActionButton;

  /// Optional bottom navigation bar.
  final Widget? bottomNavigationBar;

  /// Override for the paper background color.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => SketchyTheme.consumer(
    builder: (context, theme) => ColoredBox(
      color: backgroundColor ?? theme.paperColor,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                if (appBar != null) appBar!,
                if (body != null)
                  Expanded(
                    child: DefaultTextStyle(
                      style: theme.typography.body.copyWith(
                        color: theme.inkColor,
                      ),
                      child: body!,
                    ),
                  )
                else
                  const Spacer(),
                if (bottomNavigationBar != null) bottomNavigationBar!,
              ],
            ),
            if (floatingActionButton != null)
              Positioned(right: 24, bottom: 24, child: floatingActionButton!),
          ],
        ),
      ),
    ),
  );
}
