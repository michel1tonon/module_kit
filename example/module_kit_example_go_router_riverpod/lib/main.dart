import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';

import 'features/home/home_module.dart';
import 'features/profile/profile_module.dart';

void main() {
  runApp(const GoRouterRiverpodExampleApp());
}

class GoRouterRiverpodExampleApp extends StatelessWidget {
  const GoRouterRiverpodExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<RouteBase, Override>()
      ..addAll([
        HomeModule(),
        ProfileModule(),
      ]);

    return ModuleComposerBuilder<RouteBase, Override>(
      composer: composer,
      loading: const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      builder: (context, {required injectors, required routers}) {
        final router = GoRouter(
          initialLocation: '/',
          routes: routers,
        );

        return ProviderScope(
          overrides: injectors,
          child: MaterialApp.router(
            title: 'module_kit go_router + riverpod',
            routerConfig: router,
          ),
        );
      },
    );
  }
}
