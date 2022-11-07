import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/commons.dart';
import 'package:foodorderingappfinal/src/helpers/user.dart';
import 'package:foodorderingappfinal/src/model/orders.dart';
import 'package:foodorderingappfinal/src/model/user.dart';
import 'package:foodorderingappfinal/src/providers/app.dart';
import 'package:foodorderingappfinal/src/providers/user.dart';
import 'package:foodorderingappfinal/src/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class OrdersScreen2 extends StatefulWidget {
  User? user;
  @override
  State<OrdersScreen2> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen2> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('orders')
        .where("userId", isEqualTo: user.user!.uid)
        .snapshots();

    final app = Provider.of<AppProvider>(context);
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

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
          body: ListView(
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  leading: CustomText(
                    text: "${data["total"]} €",
                    fontWeight: FontWeight.bold,
                  ),
                  title: Text(data["cart"][0]['name']),
                  subtitle: Text(data['description']),
                  trailing: CustomText(
                    text: "${data["status"]}",
                    colors: Colors.green,
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
