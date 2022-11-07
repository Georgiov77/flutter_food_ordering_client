import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodorderingappfinal/src/model/category.dart';

class CategoryServices {
  String collection = "category";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getCategories() async =>
      await _firestore.collection(collection).get().then((value) {
        List<CategoryModel> categories = [];
        for (DocumentSnapshot category in value.docs) {
          categories.add(CategoryModel.fromSnapshot(category));
        }
        return categories;
      });
}
