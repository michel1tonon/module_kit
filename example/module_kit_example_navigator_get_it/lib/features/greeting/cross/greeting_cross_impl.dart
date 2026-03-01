import '../../../shared/cross/greeting_cross.dart';

class GreetingCrossImpl implements GreetingCross {
  @override
  String call(String param) => 'Hello, $param';
}
