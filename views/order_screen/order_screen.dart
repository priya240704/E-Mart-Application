import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../services/firestore_services.dart';
import 'order_details_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: " My Orders".text.color(Colors.white).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              return
                 "No Orders yet!".text.color(darkFontGrey).makeCentered();
            }else{
             var data=snapshot.data!.docs;
             return ListView.builder(
               itemCount: data.length,
                 itemBuilder: (BuildContext context,int index){
                   return ListTile(
                     leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                     title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                     subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                     trailing: IconButton(
                       onPressed: (){
                         Get.to(()=> OrderDetailsScreen(data: data[index],));
                       },
                       icon: Icon(Icons.arrow_forward_ios,color: darkFontGrey,),)
                   );
                 });
            }
          }),
    );
  }
}
