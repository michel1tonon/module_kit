import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/single_child_widget.dart';

import 'presentation/settings_page.dart';

class SettingsModule extends FeatureModule<RouteBase, SingleChildWidget> {
  @override
  String get name => 'settings';

  @override
  Iterable<SingleChildWidget> getInjectors(BuildContext context) => const [];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/settings',
          builder: (_, __) => const SettingsPage(),
        ),
      ];
}
