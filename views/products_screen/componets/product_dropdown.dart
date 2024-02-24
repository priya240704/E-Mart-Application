import 'package:emart_seller/Controller/product_controller.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropDown(hint,List<String> list,dropvalue, ProductsController controller){
  return Obx(
    ()=> DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint",color: fontGrey),
        value: dropvalue.value==''? null : dropvalue.value,
          isExpanded: true,
          items: list.map((e){
            return DropdownMenuItem(child: e.toString().text.make(), value: e,);
          }).toList(),
          onChanged: (newvalue){
            if(hint=="Category"){
              controller.subCategoryValue.value='';
              controller.populateSubCategory(newvalue.toString());
            }
            dropvalue.value=newvalue.toString();
          }
      ),
    ).box.white.padding(EdgeInsets.symmetric(horizontal: 4)).roundedSM.make(),
  );
}