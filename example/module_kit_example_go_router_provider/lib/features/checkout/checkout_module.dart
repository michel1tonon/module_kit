import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../shared/cross/select_country_cross.dart';
import 'checkout_controller.dart';
import 'presentation/checkout_page.dart';

class CheckoutModule extends FeatureModule<RouteBase, SingleChildWidget> {
  @override
  String get name => 'checkout';

  @override
  SingleChildWidget getInjectors(BuildContext context) {
    return ChangeNotifierProvider<CheckoutController>(
      create: (context) => CheckoutController(
        context.read<SelectCountryCross>(),
      ),
    );
  }

  @override
  RouteBase getRouters(BuildContext context) {
    return GoRoute(
      path: '/',
      builder: (_, __) => const CheckoutPage(),
    );
  }
}
