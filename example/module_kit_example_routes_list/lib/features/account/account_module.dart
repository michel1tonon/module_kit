import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';

import 'presentation/account_page.dart';

class AccountModule extends FeatureModule<List<RouteBase>, Never> {
  @override
  String get name => 'account';

  @override
  Never? getInjectors(BuildContext context) => null;

  @override
  List<RouteBase> getRouters(BuildContext context) {
    return [
      GoRoute(
        path: '/account',
        builder: (_, __) => const AccountPage(),
      ),
    ];
  }
}
