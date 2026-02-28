import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'cross/select_country_cross_impl.dart';
import 'presentation/select_country_page.dart';
import '../../shared/cross/select_country_cross.dart';

class SelectCountryModule extends FeatureModule<RouteBase, SingleChildWidget> {
  @override
  String get name => 'select_country';

  @override
  SingleChildWidget? getInjectors(BuildContext context) {
    return Provider<SelectCountryCross>(
      create: (_) => SelectCountryCrossImpl(),
    );
  }

  @override
  RouteBase? getRouters(BuildContext context) {
    return GoRoute(
      path: '/select-country',
      builder: (_, __) => const SelectCountryPage(),
    );
  }
}
