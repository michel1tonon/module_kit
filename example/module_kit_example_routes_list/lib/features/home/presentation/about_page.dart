import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/state/session_store.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<SessionStore>();

    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('This module returns a list of routes.'),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Username'),
              onSubmitted: store.updateUsername,
            ),
          ],
        ),
      ),
    );
  }
}
