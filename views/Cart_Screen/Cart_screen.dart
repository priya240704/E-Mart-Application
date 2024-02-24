import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/Cart_Screen/shipping_screen.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widget_common/login_indeicated.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar:  SizedBox(
          height: 60,
          child: ourButton(
              color: redColor,
              onPress: (){
                Get.to(()=>ShippingScreen());
              },
              textColor: whiteColor,
              title: "Proceed to shipping"
          )),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
                child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          }
          else{
            var data=snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot=data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                        itemBuilder: (BuildContext context,int index){
                        return ListTile(
                          leading: Image.network("${data[index]['img']}",width: 80,fit: BoxFit.cover,),
                          title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                          subtitle: "${data[index]['tprice']}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                          trailing: Icon(Icons.delete,color:redColor,).onTap(() {
                            FireStoreServices.deleteDocument(data[index].id);
                          }),
                       );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price".text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(()=> "${controller.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
                    ],
                  ).box.padding(EdgeInsets.all(12)).color(lightGrey).width(context.screenWidth-60).roundedSM.make(),
                  10.heightBox,
                  // SizedBox(
                  //     width: context.screenWidth-60,
                  //     child: ourButton(
                  //         color: redColor,
                  //         onPress: (){},
                  //         textColor: whiteColor,
                  //         title: "Proceed to shipping"
                  //     )),
                ],
              ),
            );

          }
        },
      )

    );
  }
}
