import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  static const ID = "id";
  static const NAME = "name";
  static const AVG_PRICE = "avgPrice";
  static const RATING = "rating";
  static const RATES = "rates";
  static const IMAGE = "image";
  static const POPULAR = "popular";
  static const EMAIL = "email";

  String? _id;
  String? _name;
  String? _email;
  String? _image;
  double? _avgPrice;
  double? _rating;
  bool? _popular;
  double? _rates;

  //getters
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  double? get avgPrice => _avgPrice;
  double? get rating => _rating;
  String? get image => _image;
  bool? get popular => _popular;
  double? get rates => _rates;

  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _name = snapshot.get(NAME);
    _email = snapshot.get(EMAIL);
    _avgPrice = snapshot.get(AVG_PRICE);
    _image = snapshot.get(IMAGE);
    _rating = snapshot.get(RATING);
    _popular = snapshot.get(POPULAR);
    _rates = snapshot.get(RATES);
  }
}
