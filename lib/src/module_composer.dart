import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_kit/src/feature_module.dart';

/// Aggregates enabled [FeatureModule]s and extracts their route and injector
/// contributions.
///
/// A project may have multiple instances — global, per domain (checkout,
/// account), or per flow (onboarding, authenticated area). The library does
/// not register routes or inject dependencies; the app shell must complete
/// the wiring (e.g. `GoRouter`, `MultiProvider`, `GetIt`).
///
/// Typical flow:
/// 1. Register modules with [addModule] or [addAll].
/// 2. Filter enabled ones with [getAllEnabledModules].
/// 3. Collect contributions with [injectors] and [routers] (or async variants).
class ModuleComposer<ROUTER, INJECTOR> {
  final List<FeatureModule<ROUTER, INJECTOR>> _modules = [];

  /// Registers a single module in the composer.
  void addModule(FeatureModule<ROUTER, INJECTOR> module) {
    _modules.add(module);
  }

  /// Registers multiple modules at once.
  void addAll(List<FeatureModule<ROUTER, INJECTOR>> modules) {
    _modules.addAll(modules);
  }

  /// Removes all registered modules.
  void clearModules() {
    _modules.clear();
  }

  /// Returns only modules whose [FeatureModule.isEnabled] is `true`.
  ///
  /// Evaluates [isEnabled] sequentially for each registered module.
  FutureOr<List<FeatureModule<ROUTER, INJECTOR>>> getAllEnabledModules(
      BuildContext context) async {
    final result = <FeatureModule<ROUTER, INJECTOR>>[];

    for (final m in _modules) {
      final enabled = await m.isEnabled(context);
      if (enabled) result.add(m);
    }

    return result;
  }

  /// Collects all injectors from [enabledModules], in registration order.
  List<INJECTOR> injectors(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.injectors(context))
        .toList();
  }

  /// Collects all routes from [enabledModules], in registration order.
  List<ROUTER> routers(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.routers(context))
        .toList();
  }

  /// Shortcut that filters enabled modules and returns aggregated injectors.
  Future<List<INJECTOR>> injectorsAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return injectors(context, enabledModules);
  }

  /// Shortcut that filters enabled modules and returns aggregated routes.
  Future<List<ROUTER>> routersAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return routers(context, enabledModules);
  }
}
