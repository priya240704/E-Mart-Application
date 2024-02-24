import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/string.dart';

Widget dashboardButton(context,{title,count,icon}){
  var size=MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment:MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title,size: 16.0,),
            boldText(text: count,size: 20.0)
          ],
        ),
      ),
      Image.asset(icon,width: 40,color: white,)
    ],
  ).box.color(purpleColor).rounded.size(size.width*0.4,80).padding(EdgeInsets.all(8)).make();
}