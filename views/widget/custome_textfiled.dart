import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/colors.dart';

Widget customeTextField({label,hint,controller,isDesc=false,textColor=Colors.black,hintColor=Colors.black}){
  return TextFormField(
    style: TextStyle(
      color: textColor,
    ),
    controller: controller,
    maxLines: isDesc ? 4:1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.black)
      ),
      focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.black)
      ),
      hintText: hint,
      hintStyle: TextStyle(color: hintColor),
    ),
  );
}