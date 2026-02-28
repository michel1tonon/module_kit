import 'package:flutter/widgets.dart';
import 'package:module_kit/src/module_composer.dart';

typedef ModuleComposerWidgetBuilder<ROUTER, INJECTOR> = Widget Function(
  BuildContext context, {
  required List<INJECTOR> injectors,
  required List<ROUTER> routers,
});

class ModuleComposerBuilder<ROUTER, INJECTOR> extends StatelessWidget {
  final ModuleComposer<ROUTER, INJECTOR> composer;

  final Widget loading;

  final Widget Function(
      BuildContext context, Object error, StackTrace? stackTrace)? errorBuilder;

  final ModuleComposerWidgetBuilder<ROUTER, INJECTOR> builder;

  const ModuleComposerBuilder({
    super.key,
    required this.composer,
    required this.builder,
    this.loading = const SizedBox.shrink(),
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_ComposerSnapshot<ROUTER, INJECTOR>>(
      future: _load(context),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          final err = snapshot.error!;
          final st = snapshot.stackTrace;
          if (errorBuilder != null) {
            return errorBuilder!(context, err, st);
          }
          return loading;
        }

        if (!snapshot.hasData) return loading;

        final data = snapshot.data!;
        return builder(
          context,
          injectors: data.injectors,
          routers: data.routers,
        );
      },
    );
  }

  Future<_ComposerSnapshot<ROUTER, INJECTOR>> _load(
      BuildContext context) async {
    final enabledModules = await composer.getAllEnabledModules(context);

    final injectors = composer.getInjectors(context, enabledModules);
    final routers = composer.getRouters(context, enabledModules);

    return _ComposerSnapshot(
      injectors: injectors,
      routers: routers,
    );
  }
}

class _ComposerSnapshot<ROUTER, INJECTOR> {
  final List<INJECTOR> injectors;
  final List<ROUTER> routers;

  _ComposerSnapshot({
    required this.injectors,
    required this.routers,
  });
}
