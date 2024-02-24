import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/controller/profile_controller.dart';
import 'package:shopping_app/widget_common/bg_widget.dart';
import 'package:shopping_app/widget_common/custom_textfiled.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/Images.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidegt(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                data['imageUrl'] == ' ' && controller.profileImagePath.isEmpty
                    ? Image.asset(
                        imgProfile2,
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : data['imageUrl'] != ' ' &&
                            controller.profileImagePath.isEmpty
                        ? Image.network(
                            data['imageUrl'],
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
                    color: redColor,
                    onPress: () {
                      controller.changeImage(context);
                    },
                    textColor: whiteColor,
                    title: "Change"),
                Divider(),
                20.heightBox,
                customTextField(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false),
                10.heightBox,
                customTextField(
                    controller: controller.oldpassController,
                    hint: passwordHint,
                    title: oldpass,
                    isPass: true),
                10.heightBox,
                customTextField(
                    controller: controller.newpassController,
                    hint: passwordHint,
                    title: newpass,
                    isPass: true),
                20.heightBox,
                controller.isLoading.value
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                            color: redColor,
                            onPress: () async {
                              controller.isLoading(true);
                              //if image is not select
                              if (controller
                                  .profileImagePath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileImageLink = data['imageUrl'];
                              }
                              //if old pass matches database
                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPssword(
                                    email: data['email'],
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
                            textColor: whiteColor,
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
