import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImage({required label,onPress}){
  return "$label".text.bold.color(fontGrey).size(16.0).makeCentered().box.color(lightGrey).size(100,100).roundedSM.make();
}