import 'package:flutter/material.dart';

class SelectCountryPage extends StatelessWidget {
  const SelectCountryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Country Module')),
      body: const Center(
        child: Text(
          'This screen belongs to select_country module.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
