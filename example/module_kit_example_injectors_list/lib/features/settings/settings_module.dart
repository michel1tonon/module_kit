import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/single_child_widget.dart';

import 'presentation/settings_page.dart';

class SettingsModule extends FeatureModule<RouteBase, List<SingleChildWidget>> {
  @override
  String get name => 'settings';

  @override
  List<SingleChildWidget> getInjectors(BuildContext context) => const [];

  @override
  RouteBase getRouters(BuildContext context) {
    return GoRoute(
      path: '/settings',
      builder: (_, __) => const SettingsPage(),
    );
  }
}
