import 'package:flutter/cupertino.dart';
import 'package:shopping_app/consts/Images.dart';
import 'package:velocity_x/velocity_x.dart';

Widget applogoWidget(){
  return Image.asset(icAppLogo).box.white.size(77, 77).padding(EdgeInsets.all(8)).rounded.make();
}