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

  List<INJECTOR> getInjectors(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.getInjectors(context))
        .toList();
  }

  List<ROUTER> getRouters(BuildContext context,
      List<FeatureModule<ROUTER, INJECTOR>> enabledModules) {
    return enabledModules
        .expand((module) => module.getRouters(context))
        .toList();
  }

  Future<List<INJECTOR>> getInjectorsAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return getInjectors(context, enabledModules);
  }

  Future<List<ROUTER>> getRoutersAsync(BuildContext context) async {
    final enabledModules = await getAllEnabledModules(context);
    return getRouters(context, enabledModules);
  }
}
