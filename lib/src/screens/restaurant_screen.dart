import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/commons.dart';
import 'package:foodorderingappfinal/src/helpers/screen_navigation.dart';
import 'package:foodorderingappfinal/src/model/restaurant.dart';
import 'package:foodorderingappfinal/src/providers/product.dart';
import 'package:foodorderingappfinal/src/widgets/custom_text.dart';
import 'package:foodorderingappfinal/src/widgets/loading.dart';
import 'package:foodorderingappfinal/src/widgets/product.dart';
import 'package:foodorderingappfinal/src/widgets/small_button.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'details.dart';

class RestaurantScreen extends StatelessWidget {
  final RestaurantModel? restaurantModel;

  const RestaurantScreen({Key? key, this.restaurantModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Stack(
            children: [
              Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: Loading(),
              )),

              // restaurant image
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: restaurantModel!.image!,
                  height: 160,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),

              // fading black
              Container(
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.05),
                        Colors.black.withOpacity(0.025),
                      ],
                    )),
              ),

              //restaurant name
              Positioned.fill(
                  bottom: 60,
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomText(
                        text: restaurantModel!.name,
                        colors: white,
                        size: 26,
                        fontWeight: FontWeight.w300,
                      ))),

              // average price
              Positioned.fill(
                bottom: 40,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomText(
                    text: "???????? ???????? ????????????????: " +
                        restaurantModel!.avgPrice.toString() +
                        "???",
                    colors: white,
                    size: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),

              // rating widget
              Positioned.fill(
                  bottom: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow[900],
                                size: 20,
                              ),
                            ),
                            Text(restaurantModel!.rating.toString()),
                          ],
                        ),
                      ),
                    ),
                  )),

              // close button
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: black.withOpacity(0.2)),
                            child: Icon(
                              Icons.close,
                              color: white,
                            )),
                      ),
                    ),
                  )),

              //like button
              Positioned.fill(
                  top: 5,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {},
                        child: SmallButton(
                          icon: Icons.favorite,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),

//              open & book section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "??????????????",
                colors: Colors.green,
                fontWeight: FontWeight.w400,
                size: 18,
              ),
              Container(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.restaurant_menu),
                  label: CustomText(text: "?????????????? ????????"),
                ),
              ),
            ],
          ),
          // products
          Column(
            children: productProvider.productsByRestaurant
                .map((item) => GestureDetector(
                      onTap: () {
                        changeScreen(context, Details(product: item));
                      },
                      child: ProductWidget(
                        product: item,
                      ),
                    ))
                .toList(),
          )
        ],
      )),
    );
  }
}
