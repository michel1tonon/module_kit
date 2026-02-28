import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../shared/state/session_store.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.watch<SessionStore>().username;

    return Scaffold(
      appBar: AppBar(title: const Text('Routes List Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Hello, $username'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.push('/account'),
              child: const Text('Open account route'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.push('/about'),
              child: const Text('Open about route'),
            ),
          ],
        ),
      ),
    );
  }
}
