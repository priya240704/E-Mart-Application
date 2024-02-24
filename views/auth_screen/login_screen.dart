import 'dart:math';

import 'package:emart_seller/Controller/auth_controller.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/consts/images.dart';
import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/views/widget/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../home_screen/home.dart';
import '../widget/loading_indicator.dart';
import '../widget/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller=Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              30.heightBox,
            normalText(text:welcome,size:18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  iclogo,width: 70,height: 70,).box.border(color: white).rounded.padding(EdgeInsets.all(8)).make(),
                10.widthBox,
                boldText(text: appname,size:20.0)
              ],
            ),

            40.heightBox,
            normalText(text: loginto,size: 20.0,color: lightGrey),
            10.heightBox,
            Obx(
                ()=> Column(
                children: [
                  TextFormField(
                    controller:controller.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: textfieldGrey,
                      hintText: emailHint,
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.email,color: purpleColor,)
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    controller:controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: textfieldGrey,
                        hintText: passwordHint,
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.lock,color: purpleColor,)
                    ),
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword,color: purpleColor))),
                  20.heightBox,
                  SizedBox(
                    width: context.screenWidth-100,
                    child:  controller.isLoading.value? loadingIndicator(): ourButton(
                      title: login,
                      onPress: ()async{
                        controller.isLoading(true);
                        await controller.loginMethod(context: context).then((value) {
                          if(value!=null){
                            VxToast.show(context, msg: "Logged in");
                            controller.isLoading(false);
                            Get.offAll(()=>Home());
                          }else{
                            controller.isLoading(false);
                          }
                        });
                        //Get.to(()=>Home());

                      }
                    ),
                  )
                ],
              ).box.white.rounded.outerShadowMd.padding(EdgeInsets.all(8)).make(),
            ),
            10.heightBox,
            Center(child: normalText(text: anyProblem,color: lightGrey)),
            Spacer(),
            Center(child: boldText(text: credit)),
            20.heightBox,
          ],
        ),
      ),
    );
  }
}
