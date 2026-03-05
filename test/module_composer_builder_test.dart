import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_kit/module_kit.dart';

void main() {
  group('module_composer_builder', () {
    testWidgets('should pass resolved routers and injectors to builder',
        (tester) async {
      final composer = ModuleComposer<String, int>()
        ..addAll([
          _BuilderTestModule(
            routers: const ['home', 'settings'],
            injectors: const [1, 2],
          ),
          _BuilderTestModule(
            routers: const ['profile'],
            injectors: const [3],
          ),
        ]);

      await tester.pumpWidget(
        MaterialApp(
          home: ModuleComposerBuilder<String, int>(
            composer: composer,
            loading: const Text('loading'),
            builder: (context, {required injectors, required routers}) {
              return Text(
                'routers=${routers.length}|injectors=${injectors.length}',
                textDirection: TextDirection.ltr,
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('routers=3|injectors=3'), findsOneWidget);
    });

    testWidgets('should render errorBuilder when composition fails',
        (tester) async {
      final composer = ModuleComposer<String, int>()
        ..addModule(_ThrowingModule());

      await tester.pumpWidget(
        MaterialApp(
          home: ModuleComposerBuilder<String, int>(
            composer: composer,
            loading: const Text('loading'),
            errorBuilder: (context, error, _) {
              return Text(
                'error: $error',
                textDirection: TextDirection.ltr,
              );
            },
            builder: (context, {required injectors, required routers}) {
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.textContaining('error: bad router module'), findsOneWidget);
    });
  });
}

class _BuilderTestModule extends FeatureModule<String, int> {
  _BuilderTestModule({
    required this.routers,
    required this.injectors,
  });

  final List<String> routers;
  final List<int> injectors;

  @override
  Iterable<String> getRouters(BuildContext context) => routers;

  @override
  Iterable<int> getInjectors(BuildContext context) => injectors;
}

class _ThrowingModule extends FeatureModule<String, int> {
  @override
  Iterable<String> getRouters(BuildContext context) {
    throw StateError('bad router module');
  }
}
