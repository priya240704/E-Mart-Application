import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/lists.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/controller/cart_controller.dart';
import 'package:shopping_app/views/home_screen/home.dart';
import 'package:shopping_app/views/home_screen/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../widget_common/login_indeicated.dart';
import '../../widget_common/our_button.dart';

class PaymentScreen extends StatefulWidget {
   PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay = Razorpay();

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
    Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {

    var controller=Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value ?
          Center(
            child: loadingIndicator(),
          ):ourButton(
            onPress: ()async{
              await controller.placeMyOrder(
                  orderPaymentMethod: paymentMethod[controller.paymentIndex.value],
                  totalAmount: controller.totalP.value);
              await controller.clearCart();
              VxToast.show(context, msg: "Order Placed successfully");

              Get.offAll(Home());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place my order",
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
              ()=> Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return GestureDetector(
                  onTap: (){
                    controller.changPaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.paymentIndex.value == index?redColor:Colors.transparent,
                        width: 1,
                        style: BorderStyle.solid
                      )
                    ),
                    margin:  EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children:[
                        Image.asset(paymentMethodImg[index],width: double.infinity,
                      height: 120,fit: BoxFit.cover,
                          colorBlendMode: controller.paymentIndex.value==index?BlendMode.darken:BlendMode.color,
                          color: controller.paymentIndex.value==index? Colors.black.withOpacity(0.4):Colors.transparent,),
                        controller.paymentIndex.value==index? Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            activeColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                            value: true, onChanged: (value){},
                          ),
                        ):Container(),
                        Positioned(
                          bottom: 10,
                            right: 10,
                            child: paymentMethod[index].text.white.fontFamily(semibold).size(16).make()),
                    ]
                    ),
                  ),
                );
              })
            ),
          ),
        ),
      ),
    );
  }
}
