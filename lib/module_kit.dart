/// Composable modular architecture for Flutter apps.
///
/// This library defines lightweight contracts to structure your app as feature
/// modules without dictating router, DI, or state management. It stays
/// framework-agnostic: you own the architecture and wiring.
///
/// ## Core concepts
///
/// - [FeatureModule] — Contract for a feature that contributes routes and
///   injectors (e.g. GoRouter, Provider, Riverpod).
/// - [ModuleComposer] — Aggregates enabled modules and collects their routers
///   and injectors.
/// - [ModuleComposerBuilder] — Widget that bootstraps modules asynchronously
///   and hands collected routers/injectors to your app shell.
/// - [CrossDependency] — Contract boundary for cross-feature integration
///   (owner module provides the implementation).
///
/// The library does not perform route registration or dependency wiring;
/// your app shell must do that. See the package README for examples.
library module_kit;

export 'src/cross_dependency.dart';
export 'src/feature_module.dart';
export 'src/module_composer_builder.dart';
export 'src/module_composer.dart';

