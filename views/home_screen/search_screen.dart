import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/category_screen/item_details.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/style.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, this.title}) : super(key: key);

    final String? title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FireStoreServices.seacrhProducts(title),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "No Product found".text.makeCentered();
          }else{
            var data=snapshot.data!.docs;
            var filter=data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 300),
                  children: filter.mapIndexed((currentValue, index) =>
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                       filter[index]['p_imgs'][0],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      Spacer(),
                      10.heightBox,
                      "${filter[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                      10.heightBox,
                      "${filter[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()
                    ],
                  ).box.white.outerShadowMd
                          .margin(EdgeInsets.symmetric(horizontal: 4))
                          .roundedSM.padding(EdgeInsets.all(12)).make().onTap(() {
                            Get.to(()=>ItemDetailsScreen(title: "${filter[index]['p_name']}",data: filter[index],));
                      })
                  ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
