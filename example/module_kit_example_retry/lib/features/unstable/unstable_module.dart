import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'presentation/unstable_page.dart';

/// Module that fails on first composition attempt and succeeds on retry.
/// Used to demonstrate ModuleComposerBuilder errorBuilder + retry flow.
class UnstableModule extends FeatureModule<RouteBase, SingleChildWidget> {
  static int _attempts = 0;

  @override
  String get name => 'unstable';

  @override
  Future<bool> isEnabled(BuildContext context) async {
    _attempts++;
    if (_attempts == 1) {
      throw StateError('isEnabled failed (simulated). Tap Retry.');
    }
    return true;
  }

  @override
  Iterable<SingleChildWidget> getInjectors(BuildContext context) => [
        Provider(create: (_) => 0),
      ];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/',
          builder: (_, __) => const UnstablePage(),
        ),
      ];
}
