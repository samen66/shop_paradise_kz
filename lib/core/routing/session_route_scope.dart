import 'package:flutter/widgets.dart';

/// Supplies session flag to [GoRouter.redirect] without reading Riverpod there
/// (avoids framework assertions during navigator build).
class SessionRouteScope extends InheritedWidget {
  const SessionRouteScope({
    super.key,
    required this.sessionStarted,
    required super.child,
  });

  final bool sessionStarted;

  /// Uses [Element.getInheritedWidgetOfExactType] so [GoRouter.redirect] does not
  /// register a dependency during navigator build (avoids framework dirty asserts).
  static bool sessionStartedOf(BuildContext context) {
    final SessionRouteScope? scope = context
        .getInheritedWidgetOfExactType<SessionRouteScope>();
    return scope?.sessionStarted ?? false;
  }

  @override
  bool updateShouldNotify(SessionRouteScope oldWidget) {
    return oldWidget.sessionStarted != sessionStarted;
  }
}
