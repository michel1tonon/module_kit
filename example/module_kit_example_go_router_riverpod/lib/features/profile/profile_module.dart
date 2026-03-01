import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';

import '../../shared/feature_flags.dart';
import '../../shared/providers/app_providers.dart';
import 'presentation/profile_page.dart';

class ProfileModule extends FeatureModule<RouteBase, Override> {
  @override
  String get name => 'profile';

  @override
  FutureOr<bool> isEnabled(BuildContext context) => FeatureFlags.enableProfile;

  @override
  Iterable<Override> getInjectors(BuildContext context) => [
        profileBadgeProvider.overrideWith((ref) => 'Pro'),
      ];

  @override
  Iterable<RouteBase> getRouters(BuildContext context) => [
        GoRoute(
          path: '/profile',
          builder: (_, __) => const ProfilePage(),
        ),
      ];
}
