import 'package:emart_seller/views/widget/custome_textfiled.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Controller/profile_controoler.dart';
import '../../consts/colors.dart';
import '../../consts/string.dart';
import '../widget/text_style.dart';

class Shopsettimg extends StatelessWidget {
  const Shopsettimg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopsetting, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopaddress: controller.shopaddresscontroller.text,
                        shopname: controller.shopnamecontroller.text,
                        shopmobile: controller.shopmobilecontroller.text,
                        shopwebsite: controller.shopwebsitecontroller.text,
                        shopdesc: controller.shopwebsitecontroller.text,
                      );
                      VxToast.show(context, msg: "Shop updated");
                    },
                    child: normalText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customeTextField(
                  label: shopname,
                  hint: shopnamehint,
                  controller: controller.shopnamecontroller),
              10.heightBox,
              customeTextField(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopaddresscontroller),
              10.heightBox,
              customeTextField(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopmobilecontroller),
              10.heightBox,
              customeTextField(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopwebsitecontroller),
              10.heightBox,
              customeTextField(
                  label: description,
                  hint: shopDesHint,
                  isDesc: true,
                  controller: controller.shopdesccontroller),
            ],
          ),
        ),
      ),
    );
  }
}
