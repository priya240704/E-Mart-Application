import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/Controller/product_controller.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:emart_seller/consts/list.dart';
import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/views/products_screen/product_details.dart';
import 'package:emart_seller/views/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../services/store_service.dart';
import '../widget/loading_indicator.dart';
import '../widget/text_style.dart';
import 'add_product_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoriList();
            Get.to(() => AddProduct());
          },
          child: Icon(Icons.add)),
      appBar: appbarWidget(products),
      body: StreamBuilder(
          stream: StoreServices.getProduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: normalText(text: "No Product yet.!", color: fontGrey));
            } else {
              var data = snapshot.data!.docs;
              print(data[0]['p_name']);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(
                          data.length,
                          (index) => Card(
                                child: ListTile(
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
                                  subtitle: Row(
                                    children: [
                                      normalText(
                                          text: "${data[index]['p_price']}",
                                          color: darkGrey),
                                      10.widthBox,
                                      boldText(
                                          text:
                                              data[index]['is_featured'] == true
                                                  ? "Featured"
                                                  : '',
                                          color: green)
                                    ],
                                  ),
                                  trailing: VxPopupMenu(
                                    arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                            children: List.generate(
                                                popupMenuTitles.length,
                                                (i) => Padding(
                                                    padding: const EdgeInsets
                                                        .all(12.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(popupMenuIcon[i],
                                                            color: data[index][
                                                                            'featured_id'] ==
                                                                        currentUser!
                                                                            .uid &&
                                                                    i == 0
                                                                ? green
                                                                : darkGrey),
                                                        10.widthBox,
                                                        normalText(
                                                            text: data[index][
                                                                            'featured_id'] ==
                                                                        currentUser!
                                                                            .uid &&
                                                                    i == 0
                                                                ? 'Remove featured'
                                                                : popupMenuTitles[
                                                                    i],
                                                            color: darkGrey)
                                                      ],
                                                    ).onTap(() {
                                                      // VxPopupMenuController().hideMenu();
                                                      switch (i) {
                                                        case 0:
                                                          if (data[index][
                                                                  'is_featured'] ==
                                                              true) {
                                                            controller
                                                                .removeFeatured(
                                                                    data[index]
                                                                        .id);
                                                            VxToast.show(
                                                                context,
                                                                msg: "Removed");
                                                          } else {
                                                            controller
                                                                .addFeatured(
                                                                    data[index]
                                                                        .id);
                                                            VxToast.show(
                                                                context,
                                                                msg: "Added");
                                                          }
                                                        case 1:
                                                          break;
                                                        case 2:
                                                          controller
                                                              .removeProduct(
                                                                  data[index]
                                                                      .id);
                                                          VxToast.show(context,
                                                              msg:
                                                                  "Product Removed");
                                                          break;
                                                        default:
                                                      }
                                                    }))))
                                        .box
                                        .white
                                        .rounded
                                        .width(200)
                                        .make(),
                                    clickType: VxClickType.singleClick,
                                    child: Icon(Icons.more_vert_rounded),
                                  ),
                                ),
                              ))),
                ),
              );
            }
          }),
    );
  }
}
