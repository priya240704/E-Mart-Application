

import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../consts/colors.dart';
import '../../../consts/style.dart';

Widget detailsCart({width,String? count,String? title}){
  return  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  ).box.white.rounded.width(width).height(60).padding(EdgeInsets.all(4)).make();
}