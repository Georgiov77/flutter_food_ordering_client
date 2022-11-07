import 'package:flutter/material.dart';
import '../helpers/category.dart';
import '../model/category.dart';

class CategoryProvider with ChangeNotifier {
  CategoryServices _categoryServices = CategoryServices();
  static List<CategoryModel> categories = [];

  CategoryProvider.initialize() {
    _loadCategories();
  }

  _loadCategories() async {
    categories = await _categoryServices.getCategories();
    notifyListeners();
  }
}
