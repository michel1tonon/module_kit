import 'package:flutter/widgets.dart';
import 'package:module_kit/module_kit.dart';

class SelectCountryInput {
  const SelectCountryInput({
    required this.context,
    this.initialCountryCode,
  });

  final BuildContext context;
  final String? initialCountryCode;
}

abstract class SelectCountryCross
    implements CrossDependency<Future<String?>, SelectCountryInput> {}
