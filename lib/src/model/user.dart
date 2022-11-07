import 'package:cloud_firestore/cloud_firestore.dart';

import 'cart_item.dart';

class UserModel {
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String? _name;
  String? _email;
  String? _id;
  String? _stripeId;
  double _priceSum = 0;
  int _quantitySum = 0;

//  getters
  String? get name => _name;
  String? get email => _email;
  String? get id => _id;
  String? get stripeId => _stripeId;

//  public variable
  List<CartItemModel>? cart;
  double? totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.get(NAME);
    _email = snapshot.get(EMAIL);
    _id = snapshot.get(ID);
    _stripeId = snapshot.get(STRIPE_ID);
    cart = convertCartItems(snapshot.get(CART));
    totalCartPrice = getTotalPrice(cart: convertCartItems(snapshot.get(CART)));
  }

  double getTotalPrice({List? cart}) {
    if (cart == null) {
      return 0;
    }
    for (CartItemModel cartItem in cart) {
      _priceSum += (cartItem.price! * cartItem.quantity!);
    }

    double total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }

  List<CartItemModel> convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}
