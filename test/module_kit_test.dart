import 'package:module_kit/module_kit.dart';
import 'package:test/test.dart';

void main() {
  group('on_ramp', () {
    test('should allow strongly typed call contract', () {
      final onRamp = _UppercaseOnRamp();
      expect(onRamp('module_kit'), 'MODULE_KIT');
    });
  });
}

class _UppercaseOnRamp implements OnRamp<String, String> {
  @override
  String call(String param) => param.toUpperCase();
}