import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/on_ramp/greeting_on_ramp.dart';
import 'presentation/home_page.dart';

class HomeModule
    extends FeatureModule<MapEntry<String, WidgetBuilder>, void Function(GetIt)> {
  @override
  String get name => 'home';

  @override
  Iterable<MapEntry<String, WidgetBuilder>> routers(BuildContext context) => [
        MapEntry(
          '/',
          (_) {
            final greetingOnRamp = GetIt.I<GreetingOnRamp>();
            return HomePage(greeting: greetingOnRamp('module_kit'));
          },
        ),
      ];
}
