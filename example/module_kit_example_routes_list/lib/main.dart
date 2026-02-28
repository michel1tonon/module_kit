import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/account/account_module.dart';
import 'features/home/home_module.dart';

void main() {
  runApp(const RoutesListExampleApp());
}

class RoutesListExampleApp extends StatelessWidget {
  const RoutesListExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<List<RouteBase>, SingleChildWidget>()
      ..addAll([
        HomeModule(),
        AccountModule(),
      ]);

    return ModuleComposerBuilder<List<RouteBase>, SingleChildWidget>(
      composer: composer,
      loading: const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      builder: (context, {required injectors, required routers}) {
        final router = GoRouter(
          routes: routers.expand((item) => item).toList(),
        );

        return MultiProvider(
          providers: injectors,
          child: MaterialApp.router(
            title: 'module_kit routes list example',
            routerConfig: router,
          ),
        );
      },
    );
  }
}
