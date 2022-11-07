import 'package:flutter/material.dart';
import 'package:foodorderingappfinal/src/helpers/commons.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? colors;
  final FontWeight? fontWeight;

  CustomText({@required this.text, this.size, this.colors, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size ?? 16,
          color: colors ?? black,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
