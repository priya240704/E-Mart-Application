import 'package:flutter/material.dart';
import 'package:shopping_app/consts/colors.dart';

Widget loadingIndicator(){
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}