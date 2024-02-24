import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/product_controller.dart';
import 'package:shopping_app/views/category_screen/categories_details.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/lists.dart';
import '../../widget_common/bg_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());


    return bgWidegt(
      child: Scaffold(
        appBar: AppBar(
          title: category.text.white.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
              mainAxisExtent: 200),
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Image.asset(categoriesImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                    10.heightBox,
                    categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(()=>CategoriesDetailsScreen(title: categoriesList[index],));
                });
              }),
        ),
      )
    );
  }
}
