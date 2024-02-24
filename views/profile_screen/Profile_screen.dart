// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_seller/Controller/auth_controller.dart';
// import 'package:emart_seller/Controller/profile_controoler.dart';
// import 'package:emart_seller/consts/colors.dart';
// import 'package:emart_seller/consts/firebase_consts.dart';
// import 'package:emart_seller/consts/images.dart';
// import 'package:emart_seller/consts/list.dart';
// import 'package:emart_seller/consts/string.dart';
// import 'package:emart_seller/views/auth_screen/login_screen.dart';
// import 'package:emart_seller/views/message_screen/message_screen.dart';
// import 'package:emart_seller/views/profile_screen/edit_profile_screen.dart';
// import 'package:emart_seller/views/widget/app_bar.dart';
// import 'package:emart_seller/views/widget/loading_indicator.dart';
// import 'package:emart_seller/views/widget/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// import '../../services/store_service.dart';
// import '../shop_setting/shop_settings_screen.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var controller=Get.put(ProfileController());
//     return Scaffold(
//       backgroundColor: purpleColor,
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: boldText(text: settings,size: 16.0),
//        actions: [
//          IconButton(onPressed: (){
//            Get.to(()=>EditProfileScreen(
//              username: controller.snapshotData['name'],
//            ));
//          },
//              icon: Icon(Icons.edit)),
//          TextButton(onPressed: ()async{
//            await Get.find<AuthController>().signoutMethod(context);
//            Get.offAll(()=>LoginScreen());
//          },
//              child: normalText(text: logout))
//        ],
//      ),
//       body: FutureBuilder(
//         future:  StoreServices.getProfile(currentUser!.uid),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if(!snapshot.hasData){
//             return loadingIndicator(circleColor: white);
//           }else{
//             var data=snapshot.data!.docs[0];
//             //controller.snapshotData=snapshot.data!.docs[0];
//             return Column(
//               children: [
//                 ListTile(
//                    // leading: controller.snapshotData['imageUrl']==''?Image.asset(imgProduct,width: 100,fit: BoxFit.cover,)
//                    // .box.roundedFull.clip(Clip.antiAlias).make()
//                    //      :Image.network(controller.snapshotData['imageUrl'],width: 100,)
//                    //         .box.roundedFull.clip(Clip.antiAlias).make(),
//                   leading: Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
//                   //title: boldText(text: "${data['name']}"),
//                  // subtitle: normalText(text: "Riya@gmail.com"),
//                  //title: boldText(text: "${controller.snapshotData['name']}"),
//                   //subtitle: normalText(text: "${controller.snapshotData['email']}"),
//                   title: boldText(text:"Priya"),
//                   subtitle: normalText(text: "PriyaSorthiya"),
//                 ),
//                 Divider(),
//                 10.heightBox,
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: List.generate(profileButtonIcon.length,
//                             (index) => ListTile(
//                           onTap: (){
//                             switch(index){
//                               case 0:
//                                 Get.to(()=>Shopsettimg());
//                                 break;
//                               case 1:
//                                 Get.to(()=>MessageScreen());
//                               default:
//                             }
//                           },
//                           leading: Icon(profileButtonIcon[index],color: white,),
//                           title: normalText(text: profileButtonTitles[index]),
//                         )),
//                   ),
//                 )
//               ],
//             );
//           }
//         },
//       ),
//
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/Controller/auth_controller.dart';
import 'package:emart_seller/consts/list.dart';
import 'package:emart_seller/views/message_screen/message_screen.dart';
import 'package:emart_seller/views/shop_setting/shop_settings_screen.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Controller/profile_controoler.dart';
import '../../consts/Images.dart';
import '../../consts/colors.dart';
import '../../consts/firebase_consts.dart';
import '../../consts/string.dart';
import '../../services/store_service.dart';
import '../auth_screen/login_screen.dart';
import '../widget/loading_indicator.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(circleColor: white),
              );
            } else {
              var data = snapshot.data!.docs[0];
              controller.snapshotData = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(children: [
                //edit profile button
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: white,
                      )).onTap(() {
                    controller.nameController.text = data['name'];
                    // Get.to(()=>EditProfileScreen(data: data,));
                    Get.to(() => EditProfileScreen(
                          username:
                              data['name'], // controller.snapshotData['name'],
                        ));
                  }),
                ),
                //user details section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      data['imageUrl'] == ''
                          ? Image.asset(
                              imgProduct,
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
                          "${data['name']}".text.white.make(),
                          "${data['email']}".text.white.make(),
                          //  "dsd".text.make(),
                          //"ssx".text.make()
                        ],
                      )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: white)),
                          onPressed: () async {
                            authController.signoutMethod(context);
                            // await Get.put(AuthController())
                            //     .signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.white.make())
                    ],
                  ),
                ),
                Divider(),
                20.heightBox,
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(
                        profileButtonIcon.length,
                        (index) => ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => Shopsettimg());
                                    break;
                                  case 1:
                                    Get.to(() => MessageScreen());
                                    break;
                                  default:
                                }
                              },
                              leading: Icon(
                                profileButtonIcon[index],
                                color: white,
                              ),
                              title:
                                  normalText(text: profileButtonTitles[index]),
                            )),
                  ),
                )
              ]));
            }
          }),
    );
  }
}
