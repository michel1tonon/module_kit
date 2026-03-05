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
          routers: const ['r1'],
          injectors: const [1],
        ))
        ..addAll([
          _TestModule(
            nameValue: 'disabled',
            enabled: false,
            routers: const ['r2'],
            injectors: const [2],
          ),
          _TestModule(
            nameValue: 'enabled_b',
            enabled: true,
            routers: const ['r3'],
            injectors: const [3],
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
            routers: const ['home', 'about'],
            injectors: const [1, 2],
          ),
          _TestModule(
            nameValue: 'b',
            enabled: true,
            routers: const ['settings'],
            injectors: const [3],
          ),
        ]);

      final enabled = await composer.getAllEnabledModules(context);
      expect(composer.getRouters(context, enabled), ['home', 'about', 'settings']);
      expect(composer.getInjectors(context, enabled), [1, 2, 3]);
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
            routers: const ['one'],
            injectors: const [10],
          ),
          _TestModule(
            nameValue: 'b',
            enabled: true,
            routers: const ['two'],
            injectors: const [20],
          ),
        ]);

      final routers = await composer.getRoutersAsync(context);
      final injectors = await composer.getInjectorsAsync(context);

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
          routers: const ['x'],
          injectors: const [1],
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
    required this.routers,
    required this.injectors,
  });

  final String nameValue;
  final bool enabled;
  final List<String> routers;
  final List<int> injectors;

  @override
  String get name => nameValue;

  @override
  Iterable<String> getRouters(BuildContext context) => routers;

  @override
  Iterable<int> getInjectors(BuildContext context) => injectors;

  @override
  Future<bool> isEnabled(BuildContext context) async => enabled;
}
