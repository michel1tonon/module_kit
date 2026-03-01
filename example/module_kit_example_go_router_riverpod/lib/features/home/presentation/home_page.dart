import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/providers/app_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(homeTitleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('go_router + riverpod')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => context.go('/profile'),
              child: const Text('Open profile'),
            ),
          ],
        ),
      ),
    );
  }
}
