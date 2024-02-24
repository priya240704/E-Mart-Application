import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/views/Cart_Screen/payment_screen.dart';
import 'package:shopping_app/widget_common/custom_textfiled.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: "shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: (){
            if(controller.addressController.text.length>10 || controller.PostalCodeController.text.length>6 ||
            controller.CityController.text.length>5 || controller.StateController.text.length>5 ||
            controller.PhoneController.text.length>10){
              Get.to(()=>PaymentScreen());
            }else{
              VxToast.show(context, msg: "Please fill the form");
            }
          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint:"Address",isPass:false,title: "Address",controller: controller.addressController),
            customTextField(hint: "City",isPass:false,title: "City",controller: controller.CityController),
            customTextField(hint: "State",isPass:false,title: "State",controller: controller.StateController),
            customTextField(hint: "Postal Code",isPass:false,title: "Postal Code",controller: controller.PostalCodeController),
            customTextField(hint: "Phone",isPass:false,title: "Phone",controller: controller.PhoneController),
          ],
        ),
      ),
    );
  }
}
