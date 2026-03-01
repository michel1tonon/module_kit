import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/cross/greeting_cross.dart';
import 'presentation/home_page.dart';

class HomeModule
    extends FeatureModule<MapEntry<String, WidgetBuilder>, void Function(GetIt)> {
  @override
  String get name => 'home';

  @override
  Iterable<MapEntry<String, WidgetBuilder>> getRouters(BuildContext context) => [
        MapEntry(
          '/',
          (_) {
            final greetingCross = GetIt.I<GreetingCross>();
            return HomePage(greeting: greetingCross('module_kit'));
          },
        ),
      ];
}
