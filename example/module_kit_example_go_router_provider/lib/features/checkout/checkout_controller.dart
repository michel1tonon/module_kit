import 'package:flutter/widgets.dart';

import '../../shared/on_ramp/select_country_on_ramp.dart';

class CheckoutController extends ChangeNotifier {
  CheckoutController(this._selectCountryOnRamp);

  final SelectCountryOnRamp _selectCountryOnRamp;

  String? selectedCountryCode;
  bool isLoading = false;

  Future<void> selectCountry(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final countryCode = await _selectCountryOnRamp(
        SelectCountryInput(
          context: context,
          initialCountryCode: selectedCountryCode,
        ),
      );
      if (countryCode != null) {
        selectedCountryCode = countryCode;
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
