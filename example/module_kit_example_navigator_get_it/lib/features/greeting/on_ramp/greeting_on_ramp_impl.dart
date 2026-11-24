import '../../../shared/on_ramp/greeting_on_ramp.dart';

class GreetingOnRampImpl implements GreetingOnRamp {
  @override
  String call(String param) => 'Hello, $param!';
}