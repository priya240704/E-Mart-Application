// // import 'package:emart_seller/Controller/profile_controoler.dart';
// // import 'package:emart_seller/consts/colors.dart';
// // import 'package:emart_seller/views/widget/loading_indicator.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:get/get_core/src/get_main.dart';
// // import 'package:velocity_x/velocity_x.dart';
// // import 'dart:io';
// // import '../../consts/images.dart';
// // import '../../consts/string.dart';
// // import '../widget/custome_textfiled.dart';
// // import '../widget/text_style.dart';
// //
// // class EditScreen extends StatefulWidget {
// //   //final String? username;
// //   final dynamic data;
// //   const EditScreen({Key? key, this.data}) : super(key: key);
// //
// //   @override
// //   State<EditScreen> createState() => _EditScreenState();
// // }
// //
// // class _EditScreenState extends State<EditScreen> {
// //   var controller=Get.find<ProfileController>();
// //   @override
// //   void initState() {
// //    controller.nameController.text=widget.data!;
// //     super.initState();
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Obx(
// //       ()=> Scaffold(
// //         resizeToAvoidBottomInset: false,
// //         backgroundColor: purpleColor,
// //           appBar: AppBar(
// //           title: boldText(text: editPRofile,size: 16.0),
// //             actions: [
// //               controller.isLoading.value? loadingIndicator():
// //             TextButton(onPressed: ()async{
// //               controller.isLoading(true);
// //               if(controller.profileImagePath.value.isNotEmpty){
// //                 await controller.uploadProfileImage();
// //               }else{
// //                 controller.profileImageLink=controller.snapshotData['imageUrl'];
// //               }
// //               if(controller.snapshotData['password']==controller.oldpassController.text){
// //                 await controller.changeAuthPssword(
// //                     email: controller.snapshotData['email'],
// //                     password: controller.oldpassController.text,
// //                     newpassword: controller.newpassController.text
// //                 );
// //                 await controller.updateProfile(
// //                     imgUrl: controller.profileImageLink,
// //                     name: controller.nameController.text,
// //                     password: controller.newpassController.text
// //                 );
// //                 VxToast.show(context, msg: "Updated");
// //               }else if(controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
// //                 await controller.updateProfile(
// //                     imgUrl: controller.profileImageLink,
// //                     name: controller.nameController.text,
// //                     password: controller.snapshotData['password']);
// //                 VxToast.show(context, msg: "Updated");
// //               }else{
// //                 VxToast.show(context, msg: "Some error occured");
// //                 controller.isLoading(false);
// //               }
// //             },
// //             child: normalText(text: save))
// //             ],
// //           ),
// //         body: Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child:Column(
// //               children: [
// //                 controller.snapshotData['imageUrl']==''&& controller.profileImagePath.isEmpty ?
// //                 Image.asset(imgProduct,width: 100,fit: BoxFit.cover,)
// //                     .box
// //                     .roundedFull
// //                     .clip(Clip.antiAlias)
// //                     .make():
// //                 controller.snapshotData['imageUrl']!=''&&controller.profileImagePath.isEmpty?
// //                 Image.network(controller.snapshotData['imageUrl'],width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
// //                 Image.file(File(controller.profileImagePath.value),
// //                   width: 100,
// //                   fit: BoxFit.cover,
// //                 ).box.roundedFull.clip(Clip.antiAlias).make(),
// //
// //                 //Image.asset(imgProduct,width: 150,).box.roundedFull.clip(Clip.antiAlias).make(),
// //                 10.heightBox,
// //                 ElevatedButton(
// //                   style: ElevatedButton.styleFrom(backgroundColor: white),
// //                     onPressed: (){
// //                     controller.changeImage(context);
// //                     },
// //                     child: normalText(text: changeImage,color: fontGrey)),
// //                 10.heightBox,
// //                 Divider(color: white,),
// //                 30.heightBox,
// //                 customeTextField(label: name,hint: "name",controller: controller.nameController),
// //                 10.heightBox,
// //                 Align(
// //                   alignment: Alignment.centerLeft,
// //                     child: boldText(text: "Change your password")),
// //                 10.heightBox,
// //                 customeTextField(label: password,hint: passwordHint,controller: controller.oldpassController),
// //                 10.heightBox,
// //                 customeTextField(label: confirmPass,hint: passwordHint,controller: controller.newpassController),
// //               ],
// //             ),
// //
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:io';
// import 'package:emart_seller/consts/colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:velocity_x/velocity_x.dart';
// import '../../Controller/profile_controoler.dart';
// import '../../consts/Images.dart';
// import '../../consts/string.dart';
// import '../widget/custome_textfiled.dart';
// import '../widget/our_button.dart';
// import '../widget/text_style.dart';
//
// class EditScreen extends StatefulWidget {
//   final String? username;
//   const EditScreen({Key? key, required this.username}) : super(key: key);
//
//   @override
//   State<EditScreen> createState() => _EditScreenState();
// }
//
// class _EditScreenState extends State<EditScreen> {
//   var controller=Get.find<ProfileController>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     controller.nameController.text=widget.username!;
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Obx(()=> Scaffold(
//         appBar: AppBar(
//         ),
//         body: Obx(()=> SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//              controller.snapshotData['imageUrl']==''&& controller.profileImagePath.isEmpty ?
//               Image.asset(imgProduct,width: 100,fit: BoxFit.cover,)
//                   .box
//                   .roundedFull
//                   .clip(Clip.antiAlias)
//                   .make():
//               controller.snapshotData['imageUrl']!=''&&controller.profileImagePath.isEmpty?
//               Image.network( controller.snapshotData['imageUrl'],width: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
//               Image.file(File(controller.profileImagePath.value),
//                 width: 100,
//                 fit: BoxFit.cover,
//               ).box.roundedFull.clip(Clip.antiAlias).make(),
//
//               10.heightBox,
//       ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: white),
//                     onPressed: (){
//                     controller.changeImage(context);
//                     },
//                     child: normalText(text: changeImage,color: fontGrey)),
//               Divider(),
//               20.heightBox,
//               customeTextField(label: name,hint: "name",controller: controller.nameController),
//               30.heightBox,
//               Align(alignment: Alignment.centerLeft,child: boldText(text: "Change youe Password"),),
//               customeTextField(label: password,hint: passwordHint,controller: controller.oldpassController),
//               10.heightBox,
//               customeTextField(label: confirmPass,hint: passwordHint,controller: controller.newpassController),
//               20.heightBox,
//               controller.isLoading.value ? CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation(red),
//               ):SizedBox(
//                   width: context.screenWidth-60,
//                   child: ourButton(color: red,onPress: ()async{
//                     controller.isLoading(true);
//                     //if image is not select
//                     if(controller.profileImagePath.value.isNotEmpty){
//                       await controller.uploadProfileImage();
//                     }else{
//                       controller.profileImageLink= controller.snapshotData['imageUrl'];
//                     }
//                     //if old pass matches database
//                     if( controller.snapshotData['password']==controller.oldpassController.text){
//                       await controller.changeAuthPssword(
//                           email:  controller.snapshotData['email'],
//                           password: controller.oldpassController.text,
//                           newpassword: controller.newpassController.text
//                       );
//                       await controller.updateProfile(
//                           imgUrl: controller.profileImageLink,
//                           name: controller.nameController.text,
//                           password: controller.newpassController.text
//                       );
//                       VxToast.show(context, msg: "Updated");
//                     }else{
//                       VxToast.show(context, msg: "Wrong old password");
//                       controller.isLoading(false);
//                     }
//                   },title: "Save")
//               )],
//           ).box.white.shadowSm.padding(EdgeInsets.all(16)).margin(EdgeInsets.only(top: 50,left: 12,right: 12)).rounded.make(),
//         ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Controller/profile_controoler.dart';
import '../../consts/Images.dart';
import '../../consts/colors.dart';
import '../../consts/string.dart';
import '../widget/custome_textfiled.dart';
import '../widget/our_button.dart';

class EditProfileScreen extends StatefulWidget {
  //final dynamic data;
  final String? username;

  const EditProfileScreen({
    Key? key,
    this.username,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(controller.snapshotData?['name']);
    controller.nameController.text = controller.snapshotData?['name'];
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.snapshotData!['imageUrl'] == null &&
                        controller.profileImagePath.isEmpty
                    ? Image.asset(
                        imgProduct,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData!['imageUrl'] != null &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(
                            controller.snapshotData!['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImagePath.value),
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourButton(
                    color: red,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    title: "Change"),
                Divider(),
                20.heightBox,
                customeTextField(
                  label: name,
                  hint: "eg.riya patel",
                  controller: controller.nameController,
                  textColor: Colors.black,
                ),
                10.heightBox,
                customeTextField(
                    label: password,
                    textColor: Colors.black,
                    hint: passwordHint,
                    controller: controller.oldpassController),
                10.heightBox,
                customeTextField(
                    label: confirmPass,
                    hint: passwordHint,
                    textColor: Colors.black,
                    controller: controller.newpassController),
                20.heightBox,
                controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(red),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                            color: red,
                            onPress: () async {
                              controller.isLoading(true);
                              //if image is not select
                              if (controller
                                  .profileImagePath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink =
                                    controller.snapshotData?['imageUrl'];
                              }
                              //if old pass matches database
                              if (controller.snapshotData!['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPssword(
                                    email: controller.snapshotData?['email'],
                                    password: controller.oldpassController.text,
                                    newpassword:
                                        controller.newpassController.text);
                                await controller.updateProfile(
                                    imgUrl: controller.profileImageLink,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpassController.text);
                                VxToast.show(context, msg: "Updated");
                              } else {
                                VxToast.show(context,
                                    msg: "Wrong old password");
                                controller.isLoading(false);
                              }
                            },
                            title: "Save"))
              ],
            )
                .box
                .white
                .shadowSm
                .padding(EdgeInsets.all(16))
                .margin(EdgeInsets.only(top: 50, left: 12, right: 12))
                .rounded
                .make(),
          ),
        ),
      ),
    );
  }
}
