import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';

import 'presentation/account_page.dart';

class AccountModule extends FeatureModule<RouteBase, Never> {
  @override
  String get name => 'account';

  @override
  Iterable<Never> getInjectors(BuildContext context) => const [];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/account',
          builder: (_, __) => const AccountPage(),
        ),
      ];
}
