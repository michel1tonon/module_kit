import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_kit/module_kit.dart';

void main() {
  group('feature_module defaults', () {
    testWidgets('should use runtimeType as default name', (tester) async {
      final module = _DefaultFeatureModule();
      expect(module.name, '_DefaultFeatureModule');
    });

    testWidgets('should provide empty routers and injectors by default',
        (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final module = _DefaultFeatureModule();
      expect(module.getRouters(context), isEmpty);
      expect(module.getInjectors(context), isEmpty);
    });

    testWidgets('should be enabled by default', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final module = _DefaultFeatureModule();
      expect(await module.isEnabled(context), isTrue);
    });
  });
}

class _DefaultFeatureModule extends FeatureModule<String, int> {}
