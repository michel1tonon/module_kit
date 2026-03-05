import 'package:module_kit/module_kit.dart';
import 'package:test/test.dart';

void main() {
  group('cross_dependency', () {
    test('should allow strongly typed call contract', () {
      final cross = _UppercaseCross();
      expect(cross('module_kit'), 'MODULE_KIT');
    });
  });
}

class _UppercaseCross implements CrossDependency<String, String> {
  @override
  String call(String param) => param.toUpperCase();
}
