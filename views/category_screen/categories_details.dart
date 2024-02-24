import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/views/category_screen/item_details.dart';
import 'package:shopping_app/widget_common/bg_widget.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/Images.dart';
import '../../consts/style.dart';
import '../../controller/product_controller.dart';
import '../../services/firestore_services.dart';

class CategoriesDetailsScreen extends StatefulWidget {
  const CategoriesDetailsScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<CategoriesDetailsScreen> createState() => _CategoriesDetailsScreenState();
}

class _CategoriesDetailsScreenState extends State<CategoriesDetailsScreen> {
  
  @override
  void initState() {
    switchCategory(widget.title);
    super.initState();
  }
  
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod=FireStoreServices.getSubCategoryProduct(title);
    }else {
      productMethod= FireStoreServices.getProducts(title);
    }
  }
  var controller=Get.find<ProductController>();
  dynamic productMethod;
  
  
  
  @override
  Widget build(BuildContext context) {
   
    return bgWidegt(
      child: Scaffold(
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                        (index) => "${controller.subcat[index]}"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .rounded
                        .white
                        .size(120, 60)
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {
                            
                          });
                        })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream:productMethod,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                }else if
                  (snapshot.data!.docs.isEmpty){
                    return Expanded(
                    child: "No product found!".text.color(darkFontGrey).makeCentered(),
                    );
                }else{
                  var data=snapshot.data!.docs;
                  return Expanded(
                          child:GridView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                    data[index]['p_imgs'][0],
                                      width: 200,
                                      height: 150,
                                      fit: BoxFit.cover,),
                                    "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                    10.heightBox
                                  ],
                                ).box.
                                white.
                                margin(EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .outerShadowSm
                                    .padding(EdgeInsets.all(8)).
                                make().onTap(() {
                                  controller.checkIfFav(data[index]);
                                  Get.to(()=>ItemDetailsScreen(title: "${data[index]['p_name']}",data: data[index],));
                                });
                              }),
                        );
                     
                }
              },
            ),
          ],
        )
      )
    );
  }
}
