import 'package:flutter/foundation.dart';

class SessionStore extends ChangeNotifier {
  String _username = 'guest';

  String get username => _username;

  void updateUsername(String value) {
    _username = value.trim().isEmpty ? 'guest' : value.trim();
    notifyListeners();
  }
}
