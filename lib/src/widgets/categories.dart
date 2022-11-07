import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/providers/category.dart';
import 'package:foodorderingappfinal/src/widgets/loading.dart';
import 'package:transparent_image/transparent_image.dart';
import '../model/category.dart';

import '../helpers/commons.dart';
import 'custom_text.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel? category;

  CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    ),
                  ),
                  Center(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: category!.image!),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
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
          Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: category!.name,
                    colors: white,
                    size: 26,
                    fontWeight: FontWeight.w300,
                  )))
        ],
      ),
    );
  }
}
