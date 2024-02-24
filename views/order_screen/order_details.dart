import 'package:emart_seller/Controller/order_controller.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/views/widget/our_button.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'componets/order_palce.dart';
import 'package:intl/intl.dart'as intl;


class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, this.data}) : super(key: key);
  final dynamic data;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller=Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.confirmed.value=widget.data['order_confirmed'];
    controller.ondelivery.value=widget.data['order_on_delivery'];
    controller.delivered.value=widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
  //  var controller=Get.put(OrderController());
    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          title:boldText(text: "Order details",color: fontGrey,size: 16.0),
          leading: IconButton(
            onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back,color: darkGrey,),
          ),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              color: green,onPress: (){
                controller.confirmed(true);
                controller.changeStatus(title: "order_confirmed",status: true,docId: widget.data.id);
            },title: "Confirm Order"
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
          children: [
            //order deliver staus section
            Visibility(
              visible: controller.confirmed.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(text: "Order Status",color: fontGrey,size: 16.0),
                  SwitchListTile(
                    activeColor: Colors.green,
                    value: true,
                      onChanged: (value){},title: boldText(text: "Placed",color: fontGrey),),
                  SwitchListTile(
                    activeColor: Colors.green,
                    value: controller.confirmed.value,
                    onChanged: (value){
                      controller.confirmed.value=value;
                    },title: boldText(text: "Confirmed",color: fontGrey),),
                  SwitchListTile(
                    activeColor: Colors.green,
                    value: controller.ondelivery.value,
                    onChanged: (value){
                      controller.ondelivery.value=value;
                      controller.changeStatus(title: "order_on_delivery",status: value,docId: widget.data.id);
                    },title: boldText(text: "On Delivery",color: fontGrey),),
                  SwitchListTile(
                    activeColor: Colors.green,
                    value: controller.delivered.value,
                    onChanged: (value){
                      controller.delivered.value=value;
                      controller.changeStatus(title: "order_delivered",status: value,docId: widget.data.id);
                    },title: boldText(text: "Delivered",color: fontGrey),)
                ],
              ).box.padding(EdgeInsets.all(8)).outerShadowMd.white.border(color: lightGrey).roundedSM.make(),
            ),
            //order details section
              Column(
                 children: [
                      orderPlaceDetails(
                         d1: "${widget.data['order_code']}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order code",
                        title2: "Shipping Method",
                    ),
                      orderPlaceDetails(

                        d1: intl.DateFormat().add_yMd().format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                          title2: "Payment Method",
                      ),
                        orderPlaceDetails(
                          d1: "Unpaid",
                          d2: "Order Placed",
                          title1: "Payment Status",
                          title2: "Delivery Status",
                      ),
                       Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    boldText(text: "Shipping Address",color: purpleColor,),
                                  //"Shipping Address".text.fontFamily(semibold).make(),
                                  "${widget.data['order_by_name']}".text.make(),
                                  "${widget.data['order_by_email']}".text.make(),
                                  "${widget.data['order_by_address']}".text.make(),
                                  "${widget.data['order_by_city']}".text.make(),
                                  "${widget.data['order_by_state']}".text.make(),
                                  "${widget.data['order_by_phone']}".text.make(),
                                  "${widget.data['order_by_postal_code']}".text.make(),
                              ],
                                  ),
                            SizedBox(
                                   width: 130,
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      boldText(text: "Total Amount",color: purpleColor),
                                      boldText(text: "${widget.data['total_amount']}",color: red,size: 16.0),
                                        //"Total Amount".text.fontFamily(semibold).make(),
                                       //"${data['total_amount']}".text.color(redColor).fontFamily(bold).make()
                            ],
                            ),
                            )
                            ],
                            )
                            )
                            ],
                            ).box.outerShadowMd.border(color: lightGrey).roundedSM.white.make(),
      Divider(),
      10.heightBox,
      boldText(text: "Order Product",color: fontGrey,size: 16.0),
      //"Order Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
      10.heightBox,
      ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children:  List.generate(
          widget.data['orders'].length,
      (index) {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
      orderPlaceDetails(
      title1: "${widget.data['orders'][index]['title']}",
      title2:" ${widget.data['orders'][index]['tprice']}",
      d1: "${widget.data['orders'][index]['qty']}x",
      d2: "Refundable"),
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
      width: 30,
      height: 20,
      color: Color(widget.data['orders'][index]['color']),
      ),
      ),
      Divider()
      ]);
      }).toList(),
      ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
      20.heightBox,
      ]
      ),
        ),
      )
      ),
    );
  }
}
