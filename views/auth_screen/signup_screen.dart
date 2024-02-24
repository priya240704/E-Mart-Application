import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/auth_controller.dart';
import 'package:shopping_app/views/home_screen/home.dart';
import 'package:shopping_app/views/home_screen/home_screen.dart';
import 'package:shopping_app/widget_common/applogo_widegt.dart';
import 'package:shopping_app/widget_common/bg_widget.dart';
import 'package:shopping_app/widget_common/custom_textfiled.dart';
import 'package:shopping_app/widget_common/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/firebase_const.dart';
import '../../consts/lists.dart';
import '../../consts/string.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller=Get.put(AuthController());

  //text controller
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var passwordretypeController=TextEditingController();

  bool? isCheck=false;
  //bgwidegt su kam file banvi km k all screen ma same hatu atal eni file create kri
  @override
  Widget build(BuildContext context) {
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
                "Join the  $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,

                Obx(()=>
                   Column(
                    children: [
                      customTextField(hint:nameHint,title: name,controller: nameController,isPass: false),
                      customTextField(hint:emailhint,title: email,controller: emailController,isPass: false),
                      customTextField(hint: passwordHint,title: password,controller: passwordController,isPass: true),
                      customTextField(hint: passwordHint,title: retypepass,controller: passwordretypeController,isPass: true),
                      Row(
                        children: [
                          Checkbox(
                            activeColor: redColor,
                            value: isCheck,
                              onChanged: (newValue){
                             setState(() {
                               isCheck=newValue;
                             });
                              },
                            checkColor: whiteColor,
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "I Agree to the",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey
                                  )
                                ),
                                TextSpan(text: termAndCond ,
                                    style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor
                                    )
                                ),
                                TextSpan(text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular,
                                        color: fontGrey
                                    )
                                ),
                                TextSpan(text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: regular,
                                        color: redColor
                                    )
                                )
                              ]
                            )),
                          )
                        ],
                      ),
                      5.heightBox,
                      controller.isLoading.value? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ):ourButton(
                          color: isCheck==true? redColor : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          onPress: ()async{
                            if(isCheck != false){
                              controller.isLoading(true);
                              try{
                                await controller.signupMethod(context: context,email: emailController.text,password: passwordController.text).then((value) {
                                  return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg:loggedin);
                                  Get.offAll(()=> const Home());
                                });
                              }catch(e){
                                auth.signOut();
                                VxToast.show(context, msg:e.toString());
                                controller.isLoading(false);
                              }
                            }
                      }
                      ).box.width(context.screenWidth-50).make(),
                      10.heightBox,
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         alreadyHaveAccount.text.color(fontGrey).make(),
                         login.text.color(redColor).make().onTap(() {
                           Get.back();
                         })
                       ],
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
