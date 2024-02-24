import 'package:flutter/cupertino.dart';
import 'package:shopping_app/consts/Images.dart';

Widget bgWidegt({Widget? child}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(imgBackground),
      fit: BoxFit.fill)
    ),
    child: child,
  );
}