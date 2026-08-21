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
            paramRouters: const ['home', 'settings'],
            paramInjectors: const [1, 2],
          ),
          _BuilderTestModule(
            paramRouters: const ['profile'],
            paramInjectors: const [3],
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
      expect(find.textContaining('error: Bad state: bad router module'), findsOneWidget);
    });
  });
}

class _BuilderTestModule extends FeatureModule<String, int> {
  _BuilderTestModule({
    required this.paramRouters,
    required this.paramInjectors,
  });

  final List<String> paramRouters;
  final List<int> paramInjectors;

  @override
  Iterable<String> routers(BuildContext context) => paramRouters;

  @override
  Iterable<int> injectors(BuildContext context) => paramInjectors;
}

class _ThrowingModule extends FeatureModule<String, int> {
  @override
  Iterable<String> routers(BuildContext context) {
    throw StateError('bad router module');
  }
}
