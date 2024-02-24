import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/Images.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/home_controller.dart';
import 'package:shopping_app/views/Cart_Screen/Cart_screen.dart';
import 'package:shopping_app/views/home_screen/home_screen.dart';
import 'package:shopping_app/views/profile_screen/profile_screen.dart';

import '../../widget_common/exit_dialog.dart';
import '../category_screen/category_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init home controoler
    var controller=Get.put(HomeController());

    var navbarItem=[
      BottomNavigationBarItem(icon:Image.asset(icHome,width: 26),label: home),
      BottomNavigationBarItem(icon:Image.asset(icCategories,width: 26),label: category),
      BottomNavigationBarItem(icon:Image.asset(icCart,width: 26),label: cart),
      BottomNavigationBarItem(icon:Image.asset(icProfile,width: 26),label: account),
    ];

    var navBody=[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: ()async{
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(
              ()=> Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(
          ()=> BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            backgroundColor: whiteColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: semibold),
            items:navbarItem,
            onTap: (value){
              controller.currentNavIndex.value=value;
            },
          ),
        ),
      ),
    );
  }
}
