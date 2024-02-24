import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/controller/product_controller.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/Images.dart';
import '../../consts/colors.dart';
import '../../consts/lists.dart';
import '../../consts/style.dart';
import '../chat_screen/chat_screen.dart';
import '../dynamic_link.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({Key? key, required this.title, this.data}) : super(key: key);

  final String? title;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: (){
                  DynamicLinkProider().createlink("dkfkdfkg33444").then((value) {
                    Share.share(value);
                  });
                },
                icon: Icon(Icons.share,)
            ),
            Obx(
              ()=> IconButton(
                  onPressed: (){
                    if(controller.isFav.value){
                      controller.removeFromWishlist(data.id,context);
                     // controller.isFav(false);
                    }else{
                      controller.addtoWishlist(data.id,context);
                     // controller.isFav(true);
                    }
                  },
                  icon: Icon(Icons.favorite_outlined,
                  color: controller.isFav.value? redColor:darkFontGrey,)
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //swiper setion

                    VxSwiper.builder(
                      autoPlay: true,
                        itemCount: data['p_imgs'].length,
                        height: 350,
                        aspectRatio: 16/9,
                        viewportFraction: 1.0,
                        itemBuilder: (context,index){
                          return Image.network(data['p_imgs'][index],
                          width: double.infinity,
                          fit: BoxFit.cover,);
                        }),
                    10.heightBox,
                    //title and details section
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,

                    //rating
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                        onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                        selectionColor: golden,
                      size: 25,
                     maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make()
                            ],
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded,color: darkFontGrey,),
                        ).onTap(() {
                          Get.to(()=>ChatScreen(),
                            arguments: [data['p_seller'],
                              data['vendor_id']
                            ],
                          );
                        })
                      ],
                    ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                    //color section
                    20.heightBox,
                    Obx(
                      ()=> Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color:".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                        (index) =>
                                    Stack(
                                      alignment:Alignment.center,
                                      children: [
                                        VxBox()
                                          .size(40, 40)
                                          .roundedFull
                                          .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                          .margin(EdgeInsets.symmetric(horizontal: 6))
                                          .make().onTap(() {
                                            controller.changeColorIndex(index);
                                        }),
                                       Visibility(
                                         visible: index==controller.colorIndex.value,
                                           child:  Icon(Icons.done,color: Colors.white,))
                                  ]
                                    )),
                              )
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //quantity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity:".text.color(textfieldGrey).make(),
                              ),
                              Obx(
                                  ()=> Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      controller.descressQuantity();
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    },
                                        icon: Icon(Icons.remove),
                                        ),
                                    controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(onPressed: (){
                                      controller.incressQuantity(
                                        int.parse(data['p_quantity']));
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                    },
                                      icon: Icon(Icons.add),
                                    ),
                                    10.widthBox,
                                    "(${data['p_quantity']} available)".text.color(textfieldGrey).make()
                                  ]
                                ),
                              ),

                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),

                          //total row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total:".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description ".text.color(darkFontGrey).fontFamily(semibold).make(),
                10.heightBox,
                "${data['p_desc']}".text.color(darkFontGrey).make(),
                    //button section
                    10.heightBox,
                   ListView(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     children: List.generate(
                         itemdetialsButtonList.length,
                             (index) => ListTile(
                               title: "${itemdetialsButtonList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                               trailing: Icon(Icons.arrow_forward),
                             )),
                   ),

                    //product many like section
                    20.heightBox,
                    productsymanylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6,
                              (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(imgP1,
                                width: 150,
                                fit: BoxFit.cover,),
                              10.heightBox,
                              "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$600".text.color(redColor).fontFamily(bold).size(16).make()
                            ],
                          ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make(),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: (){
                 if(controller.quantity.value>0){
                   controller.addToCart(
                       color: data['p_colors'][controller.colorIndex.value],
                       context: context,
                       vendorId: data['vendor_id'],
                       img: data['p_imgs'][0],
                       qty: controller.quantity.value,
                       sellername: data['p_seller'],
                       title: data['p_name'],
                       tprice: controller.totalPrice.value
                   );
                   VxToast.show(context, msg: "Added to cart");
                 }else{
                   VxToast.show(context, msg: "Minimum 1 Product is requried");
                 }
                },
                textColor: whiteColor,
                title: "Add to Cart"
              ),
            )
          ],
        ),
      ),
    );
  }
}
