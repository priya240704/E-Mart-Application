import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/Images.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/home_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/home_screen/componets/feature_button.dart';
import 'package:shopping_app/views/home_screen/search_screen.dart';
import 'package:shopping_app/widget_common/home_button.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/lists.dart';
import '../../consts/string.dart';
import '../category_screen/item_details.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller=Get.find<HomeController>();
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey),
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if(controller.searchController.text.isNotEmptyAndNotNull){
                      Get.to(()=>SearchScreen(title: controller.searchController.text,));
                    }
                  })
                ),
              ).box.outerShadowSm.make(),
            ),
            5.heightBox,
           Expanded(
             child: SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Column(
                 children: [
                   //vxswaper berand
                   VxSwiper.builder(
                     aspectRatio: 16/9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: sliderlist.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Image.asset(
                         sliderlist[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();

                     },),
                   10.heightBox,
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: List.generate(2, (index) => homeButton(
                         width:context.screenWidth/3.5,
                         height:context.screenHeight*0.15,
                         icon:index==0? icTodaysDeal:icFlashDeal,
                         title:index==0 ? todayDeal:flashsale,
                         onPress:(){}
                     )),
                   ),
                   //seconf swper
                   10.heightBox,
                   VxSwiper.builder(
                     aspectRatio: 16/9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: Secondsliderlist.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Image.asset(
                         Secondsliderlist[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                     },),
                   10.heightBox,
                     Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: List.generate(3, (index) => homeButton(
                       width:context.screenWidth/1.5,
                       height:context.screenHeight*0.15,
                       icon: index==0 ? icTopCategories : index==1 ? icBrands:icTopSeller,
                       title: index==0? topCategories : index==1 ?brand:topSeller,
                     )
                     ),
                   ),
                   //feature category
                   10.heightBox,
                   Align(
                       alignment: Alignment.centerLeft,
                       child: featureCategori.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                   20.heightBox,
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       children: List.generate(3,
                               (index) => Column(
                                 children: [
                                   featureButton(icon: featuredImage1[index],title: featuredtitle1[index]),
                                   10.heightBox,
                                   featureButton(icon: featuredImage2[index],title: featuredtitle2[index]),
                                 ],
                               )
                       ).toList(),
                     ),
                   ),
                   //feature product
                   20.heightBox,
                   Container(
                     padding: EdgeInsets.all(12),
                     width: double.infinity,
                     decoration: BoxDecoration(
                       color: redColor,
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         featyredProduct.text.white.fontFamily(bold).size(18).make(),
                         10.heightBox,
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: FutureBuilder(
                             future: FireStoreServices.getFeaturePRoducts(),
                             builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                               if(!snapshot.hasData){
                                 return Center(child: loadingIndicator());
                               }else if(snapshot.data!.docs.isEmpty){
                                 return "No Featured Products".text.color(whiteColor).makeCentered();
                               }else{
                                 var featureddata=snapshot.data!.docs;
                                 return  Row(
                                   children: List.generate(
                                     featureddata.length,
                                         (index) => Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Image.network(
                                         featureddata[index]["p_imgs"][0],
                                           width: 150,
                                           height: 130,
                                           fit: BoxFit.cover,),
                                         10.heightBox,
                                         "${ featureddata[index]["p_name"]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                         10.heightBox,
                                         "${ featureddata[index]["p_price"]}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make()
                                       ],
                                     ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make().onTap(() {
                                                  Get.to(()=>ItemDetailsScreen(title: "${featureddata[index]['p_name']}",data: featureddata[index],));
                                         }),
                                   ),
                                 );
                               }
                             },

                           ),
                         )
                       ],
                     ),
                   ),
                   //third swpier
                  20.heightBox,
                   VxSwiper.builder(
                     aspectRatio: 16/9,
                     autoPlay: true,
                     height: 150,
                     enlargeCenterPage: true,
                     itemCount: Secondsliderlist.length,
                     itemBuilder: (BuildContext context, int index) {
                       return Image.asset(
                         Secondsliderlist[index],
                         fit: BoxFit.fill,
                       ).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                     },),

                   //all product
                   20.heightBox,
                   Align(
                       alignment: Alignment.centerLeft,
                       child: allproduct.text.color(darkFontGrey).size(18).fontFamily(semibold).make()),
                   20.heightBox,
                   StreamBuilder(
                     stream:  FireStoreServices.allproduct(),
                       builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                       if(!snapshot.hasData){
                         return loadingIndicator();
                       }else{
                         var allproductdata=snapshot.data!.docs;
                         return GridView.builder(
                             physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: allproductdata.length,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300),
                             itemBuilder: (context,index){
                               return Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Image.network(
                                     allproductdata[index]['p_imgs'][0],
                                     height: 200,
                                     width: 200,
                                     fit: BoxFit.cover,
                                   ),
                                   Spacer(),
                                   10.heightBox,
                                   "${allproductdata[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                   10.heightBox,
                                   "${allproductdata[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()
                                 ],
                               ).box
                                   .white
                                   .margin(EdgeInsets.symmetric(horizontal: 4))
                                   .roundedSM.padding(EdgeInsets.all(12))
                                   .make().onTap(() {
                                     Get.to(()=>ItemDetailsScreen(title: "${allproductdata[index]['p_name']}",data: allproductdata[index],));
                                  });
                             });
                       }
             })
                 ],
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
