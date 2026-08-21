import 'package:flutter/widgets.dart';
import 'package:module_kit/src/module_composer.dart';

/// Callback that builds the app root widget after module bootstrap.
typedef ModuleComposerWidgetBuilder<ROUTER, INJECTOR> = Widget Function(
  BuildContext context, {
  required List<INJECTOR> injectors,
  required List<ROUTER> routers,
});

/// Optional async bootstrap widget in the widget tree.
///
/// Resolves enabled modules via [composer], aggregates routes and injectors,
/// and delegates final wiring to [builder]. Shows [loading] while resolving
/// and, on failure, uses [errorBuilder] (or falls back to [loading]).
///
/// For retry after failure, wrap in a `StatefulWidget` and change the builder's
/// `key` on each attempt (see `example/module_kit_example_retry`).
///
/// Not required — the same flow can be done manually with
/// [ModuleComposer.getAllEnabledModules], [ModuleComposer.injectors], and
/// [ModuleComposer.routers].
class ModuleComposerBuilder<ROUTER, INJECTOR> extends StatelessWidget {
  /// Composer that aggregates the application's modules.
  final ModuleComposer<ROUTER, INJECTOR> composer;

  /// Widget shown while modules are being resolved.
  final Widget loading;

  /// Widget shown when loading fails. Receives error and stack trace.
  ///
  /// When `null`, falls back to [loading].
  final Widget Function(
      BuildContext context, Object error, StackTrace? stackTrace)? errorBuilder;

  /// Builds the app shell with the aggregated injector and route lists.
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

  /// Loads enabled modules and aggregates contributions into a snapshot.
  Future<_ComposerSnapshot<ROUTER, INJECTOR>> _load(
      BuildContext context) async {
    final enabledModules = await composer.getAllEnabledModules(context);

    final injectors = composer.injectors(context, enabledModules);
    final routers = composer.routers(context, enabledModules);

    return _ComposerSnapshot(
      injectors: injectors,
      routers: routers,
    );
  }
}

/// Internal result of the async module loading step.
class _ComposerSnapshot<ROUTER, INJECTOR> {
  final List<INJECTOR> injectors;
  final List<ROUTER> routers;

  _ComposerSnapshot({
    required this.injectors,
    required this.routers,
  });
}
