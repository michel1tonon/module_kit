# module_kit

`module_kit` helps you compose modular Flutter applications without owning your architecture.

## Philosophy

This package is **not a framework**.

- It does not decide your folder structure.
- It does not force a router, DI, or state management solution.
- It does not "take over" your app lifecycle.

The goal is to stay as invisible as possible: small contracts, predictable composition, and freedom for your team to keep coding the way it already does.

It also means this library does not do anything by itself.
You still need to finish wiring dependency injection and route registration in your app shell.
If those final steps are missing, your modules will not be reachable.

This lib does not do magic, but remember: every magic has a price. :)

## Micro frontends and multi-package friendly

`module_kit` works well for teams that want to scale features as isolated modules.

- Start simple with local `features/` inside one app.
- Evolve incrementally to multi-package/monorepo setups.
- Keep composition in the app shell, while each feature owns its internals.

This means your architecture can move from "modular folders" to "modular packages" without changing the core contracts.

## What this package does

- Defines a `FeatureModule<ROUTER, INJECTOR>` contract.
- Composes enabled modules through `ModuleComposer`.
- Aggregates routers and injectors from enabled modules.
- Provides `ModuleComposerBuilder` for async bootstrap in the widget tree.
- Provides `CrossDependency<RETURN, PARAM>` as a contract boundary between modules.

## Recommended project structure (consumer apps)

You can organize your app with either `lib/` or `src/` as root.

### Level 1: single app, local features

Use this when you want a simple start:

```text
lib/
  features/
    select_country/
      select_country_module.dart
      cross/
        select_country_cross_impl.dart
    checkout/
      checkout_module.dart
  shared/
    cross/
      select_country_cross.dart
```

### Level 2: monorepo, multi-package features

Use this when you want stronger feature isolation and independent package evolution:

```text
lib/
  main.dart
  features/
    select_country_feature/
      lib/
        select_country_module.dart
        cross/
          select_country_cross_impl.dart
    checkout_feature/
      lib/
        checkout_module.dart
  shared/
    cross/
      lib/
        select_country_cross.dart
```

Both levels use the same `FeatureModule<ROUTER, INJECTOR>` composition model.

## Feature boundary rules

To support micro frontend and multi-package architectures, prefer these boundaries:

- Feature modules depend on `shared` contracts, not on other feature internals.
- Cross-feature integration goes through `CrossDependency` contracts in `shared`.
- The owner feature provides the concrete implementation of its contract.
- The app shell (`main`) composes enabled modules and wires dependencies.

## CrossDependency guidelines

`CrossDependency` should live in `shared` as a known contract.

- Everyone can depend on the contract.
- Only the owner module provides the implementation.

### 1) Contract in shared

```dart
import 'package:module_kit/module_kit.dart';

abstract class SelectCountryCross
    implements CrossDependency<Future<String?>, String> {}
```

### 2) Implementation in owner feature module

```dart
class SelectCountryCrossImpl implements SelectCountryCross {
  @override
  Future<String?> call(String initialCountryCode) async {
    // owner module flow
    return initialCountryCode;
  }
}
```

This keeps boundaries explicit and avoids leaking feature internals across modules.

## Quick start

```dart
final composer = ModuleComposer<Object, Object>()
  ..addAll([
    // FeatureModule<Object, Object> implementations
  ]);
```

Use `ModuleComposerBuilder` to resolve enabled modules and collect injectors/routers before building your app shell.

## Examples

- `example/module_kit_example_go_router_provider`: baseline composition with `go_router + provider` and `CrossDependency`.
- `example/module_kit_example_navigator_get_it`: custom Navigator routes (`MapEntry`) with dependency registration via `get_it`.
- `example/module_kit_example_go_router_riverpod`: composition with `go_router + flutter_riverpod` using `Override` contributions.
- `example/module_kit_example_retry`: retry flow using `ModuleComposerBuilder` `errorBuilder`.

Each example focuses on a different integration style while keeping the same `FeatureModule` and `ModuleComposer` contracts.

## Status

The package focuses on small, stable contracts for modular composition.  
It is designed to be simple to adopt incrementally in existing Flutter apps.
