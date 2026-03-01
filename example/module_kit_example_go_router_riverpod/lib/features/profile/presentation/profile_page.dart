import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/app_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final badge = ref.watch(profileBadgeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Text('Account tier: $badge'),
      ),
    );
  }
}
