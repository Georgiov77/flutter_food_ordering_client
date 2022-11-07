import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/commons.dart';
import 'package:foodorderingappfinal/src/model/orders.dart';
import 'package:foodorderingappfinal/src/model/user.dart';
import 'package:foodorderingappfinal/src/providers/app.dart';
import 'package:foodorderingappfinal/src/providers/user.dart';
import 'package:foodorderingappfinal/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: CustomText(text: "Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: white,
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (_, index) {
            //  OrderModel _order = user.orders[index];
            print(user.orders.length);
            return ListTile(
              leading: CustomText(
                text: "${user.orders.length} €",
                fontWeight: FontWeight.bold,
              ),
              title: Text(""),
              subtitle:
                  Text(DateTime.fromMillisecondsSinceEpoch(100).toString()),
              trailing: CustomText(
                text: "_order.status",
                colors: Colors.green,
              ),
            );
          }),
    );
  }
}
