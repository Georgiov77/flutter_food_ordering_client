import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodorderingappfinal/src/model/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  //static const RESTAURANT_ID = "restaurantId";

  String? _id;
  String? _restaurantId;
  String? _description;
  String? _userId;
  String? _status;
  int? _createdAt;
  double? _total;

//  getters
  String? get id => _id;
  String? get restaurantId => _restaurantId;
  String? get description => _description;
  String? get userId => _userId;
  String? get status => _status;
  double? get total => _total;
  int? get createdAt => _createdAt;

  // public variable
  List<CartItemModel>? cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.get(ID);
    _description = snapshot.get(DESCRIPTION);
    _total = snapshot.get(TOTAL);
    _status = snapshot.get(STATUS);
    _userId = snapshot.get(USER_ID);
    _createdAt = snapshot.get(CREATED_AT);
    //  _restaurantId = snapshot.get(RESTAURANT_ID);

    cart = convertCartItems(snapshot.get(CART));
  }

  List<CartItemModel> convertCartItems(List? cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart!) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
