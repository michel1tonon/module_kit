import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_kit/module_kit.dart';

void main() {
  group('module_composer', () {
    testWidgets('should add modules and resolve enabled ones', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final composer = ModuleComposer<String, int>()
        ..addModule(_TestModule(
          nameValue: 'enabled_a',
          enabled: true,
          paramRouters: const ['r1'],
          paramInjectors: const [1],
        ))
        ..addAll([
          _TestModule(
            nameValue: 'disabled',
            enabled: false,
            paramRouters: const ['r2'],
            paramInjectors: const [2],
          ),
          _TestModule(
            nameValue: 'enabled_b',
            enabled: true,
            paramRouters: const ['r3'],
            paramInjectors: const [3],
          ),
        ]);

      final enabled = await composer.getAllEnabledModules(context);
      expect(enabled.map((m) => m.name), ['enabled_a', 'enabled_b']);
    });

    testWidgets('should flatten router and injector contributions',
        (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final composer = ModuleComposer<String, int>()
        ..addAll([
          _TestModule(
            nameValue: 'a',
            enabled: true,
            paramRouters: const ['home', 'about'],
            paramInjectors: const [1, 2],
          ),
          _TestModule(
            nameValue: 'b',
            enabled: true,
            paramRouters: const ['settings'],
            paramInjectors: const [3],
          ),
        ]);

      final enabled = await composer.getAllEnabledModules(context);
      expect(composer.routers(context, enabled), ['home', 'about', 'settings']);
      expect(composer.injectors(context, enabled), [1, 2, 3]);
    });

    testWidgets('should resolve async injectors and routers', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final composer = ModuleComposer<String, int>()
        ..addAll([
          _TestModule(
            nameValue: 'a',
            enabled: true,
            paramRouters: const ['one'],
            paramInjectors: const [10],
          ),
          _TestModule(
            nameValue: 'b',
            enabled: true,
            paramRouters: const ['two'],
            paramInjectors: const [20],
          ),
        ]);

      final routers = await composer.routersAsync(context);
      final injectors = await composer.injectorsAsync(context);

      expect(routers, ['one', 'two']);
      expect(injectors, [10, 20]);
    });

    testWidgets('should clear all modules', (tester) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) {
              context = ctx;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      final composer = ModuleComposer<String, int>()
        ..addModule(_TestModule(
          nameValue: 'a',
          enabled: true,
          paramRouters: const ['x'],
          paramInjectors: const [1],
        ));

      composer.clearModules();
      final enabled = await composer.getAllEnabledModules(context);
      expect(enabled, isEmpty);
    });
  });
}

class _TestModule extends FeatureModule<String, int> {
  _TestModule({
    required this.nameValue,
    required this.enabled,
    required this.paramRouters,
    required this.paramInjectors,
  });

  final String nameValue;
  final bool enabled;
  final List<String> paramRouters;
  final List<int> paramInjectors;

  @override
  String get name => nameValue;

  @override
  Iterable<String> routers(BuildContext context) => paramRouters;

  @override
  Iterable<int> injectors(BuildContext context) => paramInjectors;

  @override
  Future<bool> isEnabled(BuildContext context) async => enabled;
}
