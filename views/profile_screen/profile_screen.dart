import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/lists.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/profile_controller.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/chat_screen/messages_screen.dart';
import 'package:shopping_app/views/order_screen/order_screen.dart';
import 'package:shopping_app/views/profile_screen/edit_profile_screen.dart';
import 'package:shopping_app/widget_common/bg_widget.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/Images.dart';
import '../../consts/firebase_const.dart';
import '../../consts/string.dart';
import '../../controller/auth_controller.dart';
import '../auth_screen/login_screen.dart';
import '../wishlist_screen/wishlist_screen.dart';
import 'componets/details_card.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidegt(
        child: Scaffold(
      body: StreamBuilder(
          stream: FireStoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: ListView(children: [
                //edit profile button
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      )).onTap(() {
                    controller.nameController.text = data['name'];
                    Get.to(() => EditProfileScreen(
                          data: data,
                        ));
                    //Get.to(()=>EditProfileScreen());
                  }),
                ),
                //user details section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ' '
                          ? Image.asset(
                              imgProfile2,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              data['imageUrl'],
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      10.widthBox,
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .black
                              .make(),
                          "${data['email']}".text.black.make(),
                          //  "dsd".text.make(),
                          //"ssx".text.make()
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await Get.put(AuthController())
                                .signoutMethod(context);
                            // Get.offAll(()=>const LoginScreen());
                          },
                          child:
                              logout.text.fontFamily(semibold).blue700.make())
                    ],
                  ),
                ),
                20.heightBox,
                FutureBuilder(
                    future: FireStoreServices.getCounts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: loadingIndicator());
                      } else {
                        var countdata = snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCart(
                                count: countdata[0].toString(),
                                title: "In your cart",
                                width: context.screenWidth / 3.3),
                            detailsCart(
                                count: countdata[1].toString(),
                                title: "In your wishlist",
                                width: context.screenWidth / 3.3),
                            detailsCart(
                                count: countdata[2].toString(),
                                title: "Yours Order",
                                width: context.screenWidth / 3.3),
                          ],
                        );
                      }
                    }),
                //button section
                //40.heightBox,
                ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: lightGrey,
                          );
                        },
                        itemCount: profileButton.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => OrderScreen());
                                  break;
                                case 1:
                                  Get.to(() => WishlistScreen());
                                  break;
                                case 2:
                                  Get.to(() => MessagesScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonIcon[index],
                              width: 22,
                              color: darkFontGrey,
                            ),
                            title: "${profileButton[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        })
                    .box
                    .white
                    .rounded
                    .margin(EdgeInsets.all(12))
                    .padding(EdgeInsets.symmetric(horizontal: 16))
                    .shadowSm
                    .make()
                    .box
                    .color(redColor)
                    .make(),
              ]));
            }
          }),
    ));
  }
}
