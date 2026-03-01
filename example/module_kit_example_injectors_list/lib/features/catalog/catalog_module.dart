import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../shared/feature_flags.dart';
import 'catalog_controller.dart';
import 'catalog_repository.dart';
import 'presentation/catalog_page.dart';

class CatalogModule extends FeatureModule<RouteBase, SingleChildWidget> {
  @override
  String get name => 'catalog';

  @override
  Iterable<SingleChildWidget> getInjectors(BuildContext context) => [
        Provider<CatalogRepository>(
          create: (_) => CatalogRepository(),
        ),
        Provider<FeatureFlags>(
          create: (_) => const FeatureFlags(enablePromotions: true),
        ),
        ChangeNotifierProvider<CatalogController>(
          create: (context) => CatalogController(
            context.read<CatalogRepository>(),
          ),
        ),
      ];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/',
          builder: (_, __) => const CatalogPage(),
        ),
      ];
}
