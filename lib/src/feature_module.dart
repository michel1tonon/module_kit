import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class FeatureModule<ROUTER, INJECTOR> {
  /// The name of the module.
  ///  This can be used for logging, debugging, or as an identifier for the module.
  String get name => runtimeType.toString();

  /// Define the routes for this module.
  /// This can be a list of route definitions or a router object depending on your routing solution.
  /// it can be GoRouter, AutoRoute, etc.
  ROUTER? getRouters(BuildContext context);

  // it can be Provider, Bloc, Cubit, etc.
  INJECTOR? getInjectors(BuildContext context);

  /// Whether the module is enabled or not.
  /// This can be used to conditionally enable/disable modules based on certain conditions
  /// (e.g., user permissions, environment, etc.)
  FutureOr<bool> isEnabled(BuildContext context) => true;
}
