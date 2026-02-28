import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/checkout/checkout_module.dart';
import 'features/select_country/select_country_module.dart';

void main() {
  runApp(const ExampleBootstrapApp());
}

class ExampleBootstrapApp extends StatelessWidget {
  const ExampleBootstrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<RouteBase, SingleChildWidget>()
      ..addAll([
        SelectCountryModule(),
        CheckoutModule(),
      ]);

    return ModuleComposerBuilder<RouteBase, SingleChildWidget>(
      composer: composer,
      builder: (context, {required injectors, required routers}) {
        final router = GoRouter(
          initialLocation: '/',
          routes: routers,
        );

        return MultiProvider(
          providers: injectors,
          child: MaterialApp.router(
            title: 'module_kit example',
            routerConfig: router,
          ),
        );
      },
    );
  }
}
