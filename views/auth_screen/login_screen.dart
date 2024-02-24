import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/views/auth_screen/signup_screen.dart';
import 'package:shopping_app/views/home_screen/home.dart';
import 'package:shopping_app/widget_common/applogo_widegt.dart';
import 'package:shopping_app/widget_common/bg_widget.dart';
import 'package:shopping_app/widget_common/custom_textfiled.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/lists.dart';
import '../../consts/string.dart';
import '../../controller/auth_controller.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  //bgwidegt su kam file banvi km k all screen ma same hatu atal eni file create kri
  // and return e file num name karvyu


  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    var controller=Get.put(AuthController());
    return bgWidegt(
        child: Scaffold(
          //resizeToAvoidBottomInset atal ke overflow thy to singleSchilScroallview use nai kryu
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                //screenheight means k phone ni size ni rite add thase
                (context.screenHeight*0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,

                Obx(()=>
                   Column(
                    children: [
                      customTextField(
                          hint:emailhint,title: email,isPass: false,controller: controller.emailController),
                      customTextField(
                          hint: passwordHint,
                          title: password,
                          isPass: true,
                          controller: controller.passwordController,
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: (){},
                            child: foregetpass.text.make()),
                      ),
                      5.heightBox,
                      controller.isLoading.value? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ):ourButton(
                          color: redColor,
                          title: login,
                          textColor: whiteColor,
                          onPress: ()async{
                            controller.isLoading(true);
                            await controller.loginMethod(context: context).then((value) {
                              if(value!=null){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=>Home());
                              }else{
                                controller.isLoading(false);
                              }
                            });
                      })
                          .box
                          .width(context.screenWidth-50)
                          .make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(
                          color: lightGolden,title: signup,textColor: redColor,onPress: (){
                            Get.to(SignupScreen());
                      })
                          .box
                          .width(context.screenWidth-50)
                          .make(),

                      10.heightBox,
                      loginwith.text.color(fontGrey).make(),
                      5.heightBox,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(socialIconList[index],
                              width: 30,
                            )
                          ),
                        )),
                      )
                    ],
                  ).box.white.rounded.padding(EdgeInsets.all(16)).width(context.screenHeight-70).shadowSm.make(),
                )
              ],
            ),
          ),
        ));
  }
}
