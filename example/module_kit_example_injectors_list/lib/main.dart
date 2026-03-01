import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/catalog/catalog_module.dart';
import 'features/settings/settings_module.dart';

void main() {
  runApp(const InjectorsListExampleApp());
}

class InjectorsListExampleApp extends StatelessWidget {
  const InjectorsListExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<RouteBase, SingleChildWidget>()
      ..addAll([
        CatalogModule(),
        SettingsModule(),
      ]);

    return ModuleComposerBuilder<RouteBase, SingleChildWidget>(
      composer: composer,
      loading: const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      builder: (context, {required injectors, required routers}) {
        final router = GoRouter(routes: routers);

        return MultiProvider(
          providers: injectors,
          child: MaterialApp.router(
            title: 'module_kit injectors list example',
            routerConfig: router,
          ),
        );
      },
    );
  }
}
