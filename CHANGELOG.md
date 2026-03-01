## 1.0.0

- Initial public release of `module_kit`.

### Added

- `FeatureModule<ROUTER, INJECTOR>` contract for modular feature composition.
- `ModuleComposer<ROUTER, INJECTOR>` to register modules, resolve enabled modules, and aggregate contributions.
- `ModuleComposerBuilder<ROUTER, INJECTOR>` for async bootstrap in the widget tree.
- `CrossDependency<RETURN, PARAM>` contract to define explicit cross-module boundaries.

### Changed

- Standardized module contributions to `Iterable<ROUTER>` and `Iterable<INJECTOR>`, removing item-vs-list ambiguity.
- Updated composer aggregation to flatten contributions with predictable list outputs.

### Examples

- Added `go_router + provider` baseline example.
- Added `navigator + get_it` example to demonstrate router/DI neutrality.
- Added `go_router + flutter_riverpod` example using `Override` contributions.

### Documentation

- Expanded `README.md` with micro frontend / multi-package guidance and feature boundary rules.
- Added HTML docs under `docs/html` with core class pages, FAQ, and cookbook.
