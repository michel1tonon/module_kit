import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../checkout_controller.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout Module')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Selected country: ${controller.selectedCountryCode ?? 'none'}',
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: controller.isLoading
                  ? null
                  : () => context.read<CheckoutController>().selectCountry(context),
              child: Text(controller.isLoading ? 'Loading...' : 'Select country via Cross'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.push('/select-country'),
              child: const Text('Open select_country route'),
            ),
          ],
        ),
      ),
    );
  }
}
