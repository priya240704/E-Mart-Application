import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/Controller/order_controller.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:emart_seller/views/order_screen/order_details.dart';
import 'package:emart_seller/views/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../consts/string.dart';
import '../widget/loading_indicator.dart';
import '../widget/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: normalText(text: "No Order yet.!", color: fontGrey));
            } else {
              var data = snapshot.data!.docs;
              controller.totalOrder.value = data.length;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                        text: "${data[index]['order_code']}",
                        color: purpleColor,
                      ),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text:
                                      intl.DateFormat().add_yMd().format(time),
                                  color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red),
                            ],
                          )
                        ],
                      ),
                      trailing: boldText(
                          text: "${data[index]['total_amount']}"
                              .toString()
                              .numCurrency,
                          color: purpleColor,
                          size: 16.0),
                    ).box.margin(EdgeInsets.only(bottom: 4)).make();
                  })),
                ),
              );
            }
          }),
    );
  }
}
