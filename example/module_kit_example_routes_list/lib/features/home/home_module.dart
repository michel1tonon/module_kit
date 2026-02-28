import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../shared/state/session_store.dart';
import 'presentation/about_page.dart';
import 'presentation/home_page.dart';

class HomeModule extends FeatureModule<List<RouteBase>, SingleChildWidget> {
  @override
  String get name => 'home';

  @override
  SingleChildWidget getInjectors(BuildContext context) {
    return ChangeNotifierProvider<SessionStore>(
      create: (_) => SessionStore(),
    );
  }

  @override
  List<RouteBase> getRouters(BuildContext context) {
    return [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/about',
        builder: (_, __) => const AboutPage(),
      ),
    ];
  }
}
