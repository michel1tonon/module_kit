import 'package:flutter/foundation.dart';

import 'catalog_repository.dart';

class CatalogController extends ChangeNotifier {
  CatalogController(this._repository);

  final CatalogRepository _repository;
  String? selectedItem;

  List<String> get items => _repository.items;

  void selectItem(String value) {
    selectedItem = value;
    notifyListeners();
  }
}
