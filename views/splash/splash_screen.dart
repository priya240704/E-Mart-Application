import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/Images.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/widget_common/applogo_widegt.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/firebase_const.dart';
import '../auth_screen/login_screen.dart';
import '../home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //create a method to change screen
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
    //  Get.to(()=>LoginScreen());
      auth.authStateChanges().listen((User? user){
        if(user==null && mounted){
          Get.to(()=>LoginScreen());
        }else{
          Get.to(()=>Home());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          children: [
           Align(
             alignment: Alignment.topLeft,
               child: Image.asset(icSplashBg,width: 300,)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
