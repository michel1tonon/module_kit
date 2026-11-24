import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../shared/on_ramp/select_country_on_ramp.dart';
import 'checkout_controller.dart';
import 'presentation/checkout_page.dart';

class CheckoutModule extends FeatureModule<RouteBase, SingleChildWidget> {
  @override
  String get name => 'checkout';

  @override
  Iterable<SingleChildWidget> injectors(BuildContext context) => [
        ChangeNotifierProvider<CheckoutController>(
          create: (context) => CheckoutController(
            context.read<SelectCountryOnRamp>(),
          ),
        ),
      ];

  @override
  Iterable<RouteBase> routers(BuildContext context) => [
        GoRoute(
          path: '/',
          builder: (_, __) => const CheckoutPage(),
        ),
      ];
}
