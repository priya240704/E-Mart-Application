import 'package:emart_seller/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ourButton({title,color=purpleColor,onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        primary: color,padding: EdgeInsets.all(12)),
      onPressed: onPress,
      child: "$title".text.normal.size(16.0).make());
}