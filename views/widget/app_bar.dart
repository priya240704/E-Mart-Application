import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart'as intl;
import '../../consts/colors.dart';
import '../../consts/string.dart';

AppBar appbarWidget(title){
  return  AppBar(
    backgroundColor: white,
  automaticallyImplyLeading: false,
  title: boldText(text: title,color: fontGrey,size: 16.0),
  actions: [
  Center(
  child: normalText(text: intl.DateFormat('EEE,MMM d,''yy').format(DateTime.now()),color: purpleColor)),
  10.widthBox,
  ],
  );
}