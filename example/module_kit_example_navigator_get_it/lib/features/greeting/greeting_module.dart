import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/on_ramp/greeting_on_ramp.dart';
import 'on_ramp/greeting_on_ramp_impl.dart';

class GreetingModule
    extends FeatureModule<MapEntry<String, WidgetBuilder>, void Function(GetIt)> {
  @override
  String get name => 'greeting';

  @override
  Iterable<void Function(GetIt)> injectors(BuildContext context) => [
        (sl) {
          if (!sl.isRegistered<GreetingOnRamp>()) {
            sl.registerLazySingleton<GreetingOnRamp>(GreetingOnRampImpl.new);
          }
        },
      ];
}
