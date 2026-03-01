import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/feature_flags.dart';
import 'presentation/settings_page.dart';

class SettingsModule
    extends FeatureModule<MapEntry<String, WidgetBuilder>, void Function(GetIt)> {
  @override
  String get name => 'settings';

  @override
  Future<bool> isEnabled(BuildContext context) async => FeatureFlags.enableSettings;

  @override
  Iterable<MapEntry<String, WidgetBuilder>> getRouters(BuildContext context) => [
        MapEntry('/settings', (_) => const SettingsPage()),
      ];
}
