import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/Images.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/views/category_screen/categories_details.dart';
import 'package:velocity_x/velocity_x.dart';

Widget featureButton ({String?title,icon}){
  return Row(
    children: [
      Image.asset(icon,width: 40,fit: BoxFit.fill,),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),

    ],
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).white.padding(EdgeInsets.all(4)).roundedSM.make()
      .onTap(() {
            Get.to(()=>CategoriesDetailsScreen(title: title,));
  });
}