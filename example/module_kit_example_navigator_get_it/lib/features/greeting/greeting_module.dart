import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/cross/greeting_cross.dart';
import 'cross/greeting_cross_impl.dart';

class GreetingModule
    extends FeatureModule<MapEntry<String, WidgetBuilder>, void Function(GetIt)> {
  @override
  String get name => 'greeting';

  @override
  Iterable<void Function(GetIt)> getInjectors(BuildContext context) => [
        (sl) {
          if (!sl.isRegistered<GreetingCross>()) {
            sl.registerLazySingleton<GreetingCross>(GreetingCrossImpl.new);
          }
        },
      ];
}
