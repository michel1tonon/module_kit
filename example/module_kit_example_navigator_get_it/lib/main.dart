import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import 'features/greeting/greeting_module.dart';
import 'features/home/home_module.dart';
import 'features/settings/settings_module.dart';

typedef RouteEntry = MapEntry<String, WidgetBuilder>;
typedef RegisterDependency = void Function(GetIt sl);

void main() {
  runApp(const NavigatorGetItExampleApp());
}

class NavigatorGetItExampleApp extends StatelessWidget {
  const NavigatorGetItExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<RouteEntry, RegisterDependency>()
      ..addAll([
        GreetingModule(),
        HomeModule(),
        SettingsModule(),
      ]);

    return ModuleComposerBuilder<RouteEntry, RegisterDependency>(
      composer: composer,
      loading: const MaterialApp(home: Scaffold(body: SizedBox.shrink())),
      builder: (context, {required injectors, required routers}) {
        final sl = GetIt.I;
        for (final register in injectors) {
          register(sl);
        }

        final routeMap = <String, WidgetBuilder>{
          for (final route in routers) route.key: route.value,
        };

        return MaterialApp(
          title: 'module_kit navigator + get_it',
          initialRoute: '/',
          routes: routeMap,
        );
      },
    );
  }
}
