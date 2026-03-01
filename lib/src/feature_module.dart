import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class FeatureModule<ROUTER, INJECTOR> {
  /// The name of the module.
  ///  This can be used for logging, debugging, or as an identifier for the module.
  String get name => runtimeType.toString();

  /// Define the routes for this module.
  /// Return a collection of route contributions from this module.
  /// it can be GoRouter, AutoRoute, etc.
  Iterable<ROUTER> getRouters(BuildContext context) => const [];

  // it can be Provider, Bloc, Cubit, etc.
  Iterable<INJECTOR> getInjectors(BuildContext context) => const [];

  /// Whether the module is enabled or not.
  /// This can be used to conditionally enable/disable modules based on certain conditions
  /// (e.g., user permissions, environment, etc.)
  FutureOr<bool> isEnabled(BuildContext context) => true;
}
