import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/screen_navigation.dart';
import 'package:foodorderingappfinal/src/model/products.dart';
import 'package:foodorderingappfinal/src/providers/app.dart';
import 'package:foodorderingappfinal/src/providers/product.dart';
import 'package:foodorderingappfinal/src/providers/user.dart';
import 'package:foodorderingappfinal/src/widgets/custom_text.dart';
import 'package:foodorderingappfinal/src/widgets/loading.dart';
import 'package:foodorderingappfinal/src/widgets/small_button.dart';
import 'package:provider/provider.dart';

import '../helpers/commons.dart';
import 'cart.dart';

class Details extends StatefulWidget {
  final ProductModel? product;

  const Details({required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage(
                widget.product!.image!,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomText(
                text: widget.product!.name,
                size: 26,
                fontWeight: FontWeight.bold),
            CustomText(
                text: "${widget.product!.price} €",
                size: 20,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 10,
            ),
            CustomText(
                text: "Σχετικά με το Προϊόν",
                size: 18,
                fontWeight: FontWeight.w400),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.product!.description!,
                textAlign: TextAlign.center,
                style: TextStyle(color: grey, fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.remove,
                        size: 36,
                      ),
                      onPressed: () {
                        if (quantity != 1) {
                          setState(() {
                            quantity -= 1;
                          });
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () async {
                    app.changeLoading();
                    // print("Loading");
                    bool value = await user.addToCart(
                        product: widget.product, quantity: quantity);
                    if (value) {
                      //   print("item added to cart");
                      _key.currentState!.showSnackBar(
                        SnackBar(
                          content: Text("Το προϊόν προστέθηκε στο καλάθι!"),
                        ),
                      );
                      user.reloadUserModel();
                      app.changeLoading();
                      return;
                    } else {}
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: red, borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                      child: CustomText(
                        text: "Προσθήκη $quantity στο καλάθι",
                        colors: white,
                        size: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.add,
                        size: 36,
                        color: red,
                      ),
                      onPressed: () {
                        setState(() {
                          quantity += 1;
                        });
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
