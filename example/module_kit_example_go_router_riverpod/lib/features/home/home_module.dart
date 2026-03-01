import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/providers/app_providers.dart';
import 'presentation/home_page.dart';

class HomeModule extends FeatureModule<RouteBase, Override> {
  @override
  String get name => 'home';

  @override
  Iterable<Override> getInjectors(BuildContext context) => [
        homeTitleProvider.overrideWith((ref) => 'Home powered by HomeModule'),
      ];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/',
          builder: (_, __) => const HomePage(),
        ),
      ];
}
