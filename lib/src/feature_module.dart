import 'dart:async';

import 'package:flutter/widgets.dart';

/// Minimal contract that a feature module must implement.
///
/// Each module contributes routes ([ROUTER]) and injectors ([INJECTOR])
/// for the app shell to wire up. The library does not enforce a stack:
/// [ROUTER] can be `RouteBase` (go_router), `MapEntry<String, WidgetBuilder>`
/// (Navigator), etc.; [INJECTOR] can be `SingleChildWidget` (Provider),
/// `Override` (Riverpod), `void Function(GetIt)` (get_it), etc.
///
/// Methods may return empty collections (`const []`) when the module
/// contributes nothing for that aspect.
abstract class FeatureModule<ROUTER, INJECTOR> {
  /// Module identifier name.
  ///
  /// Used for logging, debugging, or as a module key.
  /// Defaults to the implementation's [runtimeType].
  String get name => runtimeType.toString();

  /// Routes contributed by this module.
  ///
  /// The concrete type depends on the router adopted in the app
  /// (GoRouter, AutoRoute, etc.).
  Iterable<ROUTER> routers(BuildContext context) => const [];

  /// Injectors or dependency registrars contributed by this module.
  ///
  /// The concrete type depends on the DI/state solution
  /// (Provider, Riverpod, get_it, etc.).
  Iterable<INJECTOR> injectors(BuildContext context) => const [];

  /// Whether this module is enabled in the current context.
  ///
  /// Useful for feature flags, permissions, environment (dev/stage/prod),
  /// or remote config. When `false`, [ModuleComposer] ignores this module's
  /// contributions.
  FutureOr<bool> isEnabled(BuildContext context) => true;
}
