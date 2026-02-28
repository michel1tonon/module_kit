import 'package:flutter/widgets.dart';

import '../../shared/cross/select_country_cross.dart';

class CheckoutController extends ChangeNotifier {
  CheckoutController(this._selectCountryCross);

  final SelectCountryCross _selectCountryCross;

  String? selectedCountryCode;
  bool isLoading = false;

  Future<void> selectCountry(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final countryCode = await _selectCountryCross(
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
