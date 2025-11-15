import 'package:flutter/widgets.dart';

import '../theme/sketchy_theme.dart';
import 'sketchy_page_route.dart';

/// Signature for building Sketchy routes.
typedef SketchyRouteBuilder = WidgetBuilder;

/// Minimal app shell that wires Sketchy theming into a [WidgetsApp].
class SketchyApp extends StatelessWidget {
  /// Creates a Sketchy-powered application.
  const SketchyApp({
    required this.title,
    required this.theme,
    required this.home,
    super.key,
    this.routes,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorKey,
    this.navigatorObservers,
  });

  /// Title exposed to Flutter’s window bindings.
  final String title;

  /// Global theme configuration consumed by Sketchy widgets.
  final SketchyThemeData theme;

  /// Widget shown for the default `/` route.
  final Widget home;

  /// Optional static route table.
  final Map<String, SketchyRouteBuilder>? routes;

  /// Hook for dynamic route generation.
  final RouteFactory? onGenerateRoute;

  /// Handler invoked when no route matches.
  final RouteFactory? onUnknownRoute;

  /// Key controlling the navigator bound to this app.
  final GlobalKey<NavigatorState>? navigatorKey;

  /// Observers listening to navigator lifecycle events.
  final List<NavigatorObserver>? navigatorObservers;

  @override
  Widget build(BuildContext context) => WidgetsApp(
    navigatorKey: navigatorKey,
    title: title,
    color: theme.colors.paper,
    builder: (context, child) {
      final content = child ?? const SizedBox.shrink();
      return SketchyTheme(
        data: theme,
        child: DefaultTextStyle(
          style: theme.typography.body.copyWith(color: theme.colors.ink),
          child: content,
        ),
      );
    },
    navigatorObservers: navigatorObservers ?? const <NavigatorObserver>[],
    onGenerateRoute: (settings) {
      if (settings.name == Navigator.defaultRouteName) {
        return SketchyPageRoute(builder: (_) => home, settings: settings);
      }

      final mapBuilder = routes?[settings.name];
      if (mapBuilder != null) {
        return SketchyPageRoute(builder: mapBuilder, settings: settings);
      }

      if (onGenerateRoute != null) {
        return onGenerateRoute!(settings);
      }

      return null;
    },
    onUnknownRoute: onUnknownRoute,
  );
}
