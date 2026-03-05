import 'package:flutter/material.dart';

class UnstablePage extends StatelessWidget {
  const UnstablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Retry Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: Colors.green.shade400, size: 64),
            const SizedBox(height: 16),
            const Text('Composition succeeded after retry.'),
          ],
        ),
      ),
    );
  }
}
