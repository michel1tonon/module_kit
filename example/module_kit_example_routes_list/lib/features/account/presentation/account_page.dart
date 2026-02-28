import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/state/session_store.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final username = context.watch<SessionStore>().username;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: Center(
        child: Text('Current user: $username'),
      ),
    );
  }
}
