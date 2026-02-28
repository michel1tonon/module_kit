import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/feature_flags.dart';
import '../catalog_controller.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CatalogController>();
    final flags = context.watch<FeatureFlags>();

    return Scaffold(
      appBar: AppBar(title: const Text('Injectors List Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (flags.enablePromotions)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text('Promotions are enabled by shared flags.'),
                ),
              ),
            const SizedBox(height: 8),
            Text('Selected item: ${controller.selectedItem ?? 'none'}'),
            const SizedBox(height: 8),
            for (final item in controller.items)
              ListTile(
                title: Text(item),
                onTap: () => context.read<CatalogController>().selectItem(item),
              ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.push('/settings'),
              child: const Text('Open settings route'),
            ),
          ],
        ),
      ),
    );
  }
}
