import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/Controller/order_controller.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:emart_seller/consts/images.dart';
import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widget/app_bar.dart';
import 'package:emart_seller/views/widget/dashboard_button.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final orderController = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
            stream: StoreServices.getProduct(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child:
                        normalText(text: "No Product yet.!", color: fontGrey));
              } else {
                var data = snapshot.data!.docs;
                data = data.sortedBy((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
                print(data[0]['p_colors'][0]);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: products,
                              count: "${data.length}",
                              icon: icProducts),
                          dashboardButton(context,
                              title: orders,
                              count: "${orderController.totalOrder.value}",
                              icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: rating,
                              count: 2, //  "${data.length}",
                              icon: icStar),
                          dashboardButton(context,
                              title: totalSales,
                              count: 31000, //"${data.length}",
                              icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Divider(),
                      10.heightBox,
                      boldText(text: popular, color: fontGrey, size: 16.0),
                      20.heightBox,
                      Expanded(
                        child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                data.length,
                                (index) => data[index]['p_wishlist'].length == 0
                                    ? SizedBox()
                                    : ListTile(
                                        onTap: () {
                                          Get.to(() => ProductDetails(
                                                data: data[index],
                                              ));
                                        },
                                        leading: Image.network(
                                            data[index]['p_imgs'][0],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover),
                                        title: boldText(
                                          text: "${data[index]['p_name']}",
                                          color: fontGrey,
                                        ),
                                        subtitle: normalText(
                                            text: "\$${data[index]['p_price']}",
                                            color: darkGrey),
                                      ))),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}
