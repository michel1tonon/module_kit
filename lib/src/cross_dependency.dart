/// Contract for cross-module communication without coupling internal implementations.
///
/// Acts as a port in the shared layer: the contract lives in `src/shared`,
/// the owner module provides the adapter/implementation, and consumers
/// depend only on the interface, preserving dependency direction.
///
/// **Important:** this type is included in the library as a shared convention —
/// a lightweight reminder that modules can talk to each other through explicit
/// boundaries instead of importing each other's internals. You are not required
/// to use it. A project-local interface or abstract class that fits the same
/// role is equally valid when it keeps the same dependency direction.
///
/// **Contract location:** place every cross-module contract under `src/shared`
/// so the whole project can depend on it. Feature modules import contracts from
/// there; implementations stay inside the owner feature.
///
/// Example:
/// ```dart
/// abstract class SelectCountryCross
///     implements CrossDependency<Future<String?>, SelectCountryInput> {}
///
/// class SelectCountryCrossImpl implements SelectCountryCross {
///   @override
///   Future<String?> call(SelectCountryInput param) async => 'BR';
/// }
/// ```
abstract class CrossDependency<RETURN, PARAM> {
  /// Executes the operation defined by the contract with the given parameter.
  RETURN call(PARAM param);
}
