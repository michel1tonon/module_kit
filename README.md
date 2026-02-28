# module_kit

`module_kit` helps you compose modular Flutter applications without owning your architecture.

## Philosophy

This package is **not a framework**.

- It does not decide your folder structure.
- It does not force a router, DI, or state management solution.
- It does not "take over" your app lifecycle.

The goal is to stay as invisible as possible: small contracts, predictable composition, and freedom for your team to keep coding the way it already does.

## What this package does

- Defines a `FeatureModule<ROUTER, INJECTOR>` contract.
- Composes enabled modules through `ModuleComposer`.
- Aggregates routers and injectors from enabled modules.
- Provides `ModuleComposerBuilder` for async bootstrap in the widget tree.
- Provides `CrossDependency<RETURN, PARAM>` as a contract boundary between modules.

## Recommended project structure (consumer apps)

You can organize your app with either `lib/` or `src/` as root.  
The recommended split is:

- `features/`: packages/modules with business features.
- `shared/`: contracts and reusable building blocks consumed by features.

Example:

```text
lib/
  shared/
    cross/
      select_country_cross.dart
  features/
    select_country/
      select_country_module.dart
      cross/
        select_country_cross_impl.dart
    checkout/
      checkout_module.dart
```

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

## Status

The package focuses on small, stable contracts for modular composition.  
It is designed to be simple to adopt incrementally in existing Flutter apps.
