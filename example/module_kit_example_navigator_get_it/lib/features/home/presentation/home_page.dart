import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.greeting,
  });

  final String greeting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigator + get_it')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(greeting),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed('/settings'),
              child: const Text('Open settings'),
            ),
          ],
        ),
      ),
    );
  }
}
