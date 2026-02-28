import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/feature_flags.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promotions = context.watch<FeatureFlags>().enablePromotions;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Text('Promotions enabled: $promotions'),
      ),
    );
  }
}
