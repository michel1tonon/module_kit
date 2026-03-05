import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:module_kit/module_kit.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/unstable/unstable_module.dart';

void main() {
  runApp(const RetryExampleApp());
}

class RetryExampleApp extends StatelessWidget {
  const RetryExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'module_kit retry example',
      theme: ThemeData(useMaterial3: true),
      home: const _RetryBootstrap(),
    );
  }
}

class _RetryBootstrap extends StatefulWidget {
  const _RetryBootstrap();

  @override
  State<_RetryBootstrap> createState() => _RetryBootstrapState();
}

class _RetryBootstrapState extends State<_RetryBootstrap> {
  Object _retryKey = Object();

  void _retry() {
    setState(() {
      _retryKey = Object();
    });
  }

  @override
  Widget build(BuildContext context) {
    final composer = ModuleComposer<RouteBase, SingleChildWidget>()
      ..addAll([UnstableModule()]);

    return ModuleComposerBuilder<RouteBase, SingleChildWidget>(
      key: ValueKey(_retryKey),
      composer: composer,
      loading: const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      errorBuilder: (context, error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Module composition failed',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      builder: (context, {required injectors, required routers}) {
        final router = GoRouter(
          initialLocation: '/',
          routes: routers,
        );
        return MultiProvider(
          providers: injectors,
          child: MaterialApp.router(
            title: 'module_kit retry example',
            theme: ThemeData(useMaterial3: true),
            routerConfig: router,
          ),
        );
      },
    );
  }
}
