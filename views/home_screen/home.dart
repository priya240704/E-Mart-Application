import 'package:emart_seller/Controller/home_controller.dart';
import 'package:emart_seller/Controller/order_controller.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/consts/images.dart';
import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/order_screen/order_screen.dart';
import 'package:emart_seller/views/products_screen/product_screen.dart';
import 'package:emart_seller/views/profile_screen/Profile_screen.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var orderController = Get.put(OrderController());
    var navScreen = [
      HomeScreen(),
      ProductScreen(),
      OrderScreen(),
      ProfileScreen(),
    ];
    var bottomNavbar = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            color: darkGrey,
            width: 24,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          type: BottomNavigationBarType.fixed,
          items: bottomNavbar,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreen.elementAt(controller.navIndex.value),
            )
          ],
        ),
      ),
    );
  }
}
