import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/commons.dart';
import 'package:foodorderingappfinal/src/helpers/order.dart';
import 'package:foodorderingappfinal/src/model/cart_item.dart';
import 'package:foodorderingappfinal/src/model/products.dart';
import 'package:foodorderingappfinal/src/providers/app.dart';
import 'package:foodorderingappfinal/src/providers/user.dart';
import 'package:foodorderingappfinal/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  OrderServices _orderServices = OrderServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    double totalPrice = 0;

    return Scaffold(
        key: _key,
        appBar: AppBar(
          iconTheme: IconThemeData(color: black),
          leading: IconButton(
            icon: Icon(
              Icons.close,
              color: black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: white,
          elevation: 0,
          centerTitle: true,
          title: CustomText(
            text: "Καλάθι Αγορών",
          ),
          actions: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Stack(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(12),
            //         child: Image.asset(
            //           "images/shopping-bag.png",
            //           width: 20,
            //           height: 20,
            //         ),
            //       ),
            //       Positioned(
            //         right: 7,
            //         bottom: 5,
            //         child: Container(
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: grey300,
            //                   offset: Offset(2, 1),
            //                   blurRadius: 3,
            //                 )
            //               ],
            //               color: white),
            //           child: Padding(
            //             padding: const EdgeInsets.only(left: 4, right: 4),
            //             child: CustomText(
            //               text: "",
            //               colors: red,
            //               size: 18,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        backgroundColor: white,
        body: ListView.builder(
            itemCount: user.userModel!.cart!.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade50,
                        offset: Offset(3, 7),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        child: Image.network(
                          user.userModel!.cart![index].image!,
                          height: 120,
                          width: 140,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: user.userModel!.cart![index].name! +
                                        "\n",
                                    style:
                                        TextStyle(color: black, fontSize: 20),
                                  ),
                                  TextSpan(
                                    text: user.userModel!.cart![index].price
                                            .toString() +
                                        " €\n",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextSpan(
                                    text: "Ποσότητα: ",
                                    style: TextStyle(
                                        color: grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  TextSpan(
                                    text: user.userModel!.cart![index].quantity
                                        .toString(),
                                    style: TextStyle(
                                        color: red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            IconButton(
                              onPressed: () async {
                                app.changeLoading();
                                bool value = await user.removeFromCart(
                                    cartItem: user.userModel!.cart![index]);
                                if (value) {
                                  user.reloadUserModel();
                                  app.changeLoading();
                                  // print("Item deleted...");
                                  _key.currentState!.showSnackBar(
                                    SnackBar(
                                      content: Text("Διαγραφή από το καλάθι"),
                                    ),
                                  );
                                  return;
                                } else {
                                  // print("Item was not removed");
                                  app.changeLoading();
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: red,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
        bottomNavigationBar: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Σύνολο: ",
                        style: TextStyle(
                            color: grey,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                      TextSpan(
                        text: "${user.userModel!.totalCartPrice}€",
                        style: TextStyle(
                            color: red,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      if (user.userModel!.totalCartPrice == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Το καλάθι σου είναι άδειο',
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Κλείσιμο",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0)), //this right here
                              child: Container(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Η πληρωμή των ${user.userModel!.totalCartPrice} € \n της παραγγελίας θα γίνει \n κατά την παράδοση',
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            var uuid = Uuid();
                                            String id = uuid.v4();
                                            _orderServices.createOrder(
                                              userId: user.user!.uid,
                                              id: id,
                                              description:
                                                  "Some random description",
                                              status: "complete",
                                              totalPrice: user
                                                  .userModel!.totalCartPrice,
                                              cart: user.userModel!.cart,
                                            );

                                            for (CartItemModel cartItem
                                                in user.userModel!.cart!) {
                                              bool value =
                                                  await user.removeFromCart(
                                                      cartItem: cartItem);
                                              if (value) {
                                                user.reloadUserModel();

                                                print("Item deleted...");
                                                _key.currentState!.showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Deleted from Cart"),
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                return;
                                              } else {
                                                print("Item was not removed");
                                              }
                                            }
                                            _key.currentState!.showSnackBar(
                                              SnackBar(
                                                content: Text("Order Created!"),
                                              ),
                                            );

                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Αποδοχή",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Κλείσιμο",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: CustomText(
                      text: "Check out",
                      colors: white,
                      fontWeight: FontWeight.normal,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
