import 'dart:async';

import 'package:flutter/material.dart';
import 'package:module_kit/src/feature_module.dart';

class ModuleComposer<ROUTER, INJECTOR> {
  final List<FeatureModule<ROUTER, INJECTOR>> _modules = [];

  void addModule(FeatureModule<ROUTER, INJECTOR> module) {
    _modules.add(module);
  }

  void addAll(List<FeatureModule<ROUTER, INJECTOR>> modules) {
    _modules.addAll(modules);
  }

  void clearModules() {
    _modules.clear();
  }

  FutureOr<List<FeatureModule<ROUTER, INJECTOR>>> getAllEnabledModules(
      BuildContext context) async {
    final result = <FeatureModule<ROUTER, INJECTOR>>[];

    for (final m in _modules) {
      final enabled = await m.isEnabled(context);
      if (enabled) result.add(m);
    }

    return result;
  }

  List<INJECTOR> injectors(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.injectors(context))
        .toList();
  }

  List<ROUTER> routers(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.routers(context))
        .toList();
  }

  Future<List<INJECTOR>> injectorsAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return injectors(context, enabledModules);
  }

  Future<List<ROUTER>> routersAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return routers(context, enabledModules);
  }
}
