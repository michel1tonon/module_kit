/// Contract for cross-module communication without coupling internal implementations.
///
/// Acts as a port in the shared layer: the contract lives in `shared`,
/// the owner module provides the adapter/implementation, and consumers
/// depend only on the interface, preserving dependency direction.
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
