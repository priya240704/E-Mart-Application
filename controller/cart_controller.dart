import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/controller/home_controller.dart';

class CartController extends GetxController{
  var totalP=0.obs;
  //text controller shipping details
  var addressController=TextEditingController();
  var CityController=TextEditingController();
  var StateController=TextEditingController();
  var PostalCodeController=TextEditingController();
  var PhoneController=TextEditingController();

  var paymentIndex=0.obs;

  late dynamic productSnapshot;
  var product=[];
  var vendors=[];
  var placingOrder=false.obs;


  calculate(data){
    totalP.value=0;
    for(var i=0;i<data.length;i++){
      totalP.value=totalP.value+int.parse(data[i]['tprice'].toString());
    }
  }

  //shipping payment
changPaymentIndex(index){
    paymentIndex.value=index;
}

//add place order
  placeMyOrder({required orderPaymentMethod,required totalAmount})async{
    placingOrder(true);
      await getProductDetails();
    await firestore.collection(orderCollection).doc().set({
      "order_code":"233981237",
      "order_date":FieldValue.serverTimestamp(),
      "order_by":currentUser!.uid,
      "order_by_name":Get.find<HomeController>().username,
      "order_by_email":currentUser!.email,
      "order_by_address":addressController.text,
      "order_by_state":StateController.text,
      "order_by_city":CityController.text,
      "order_by_phone":PhoneController.text,
      "order_by_postal_code":PostalCodeController.text,
      "shipping_method":"Home Delivery",
      "payment_method":orderPaymentMethod,
      "order_placed":true,
      "order_confirmed":false,
      "order_delivered":false,
      "order_on_delivery":false,
      "total_amount":totalAmount,
      'orders':FieldValue.arrayUnion(product),
      'vendors':FieldValue.arrayUnion(vendors)
    });
    placingOrder(false);
  }

  getProductDetails(){
    product.clear();
    vendors.clear();
    for(var i=0;i<productSnapshot.length;i++){
      product.add({
        'color':productSnapshot[i]['color'],
        'img':productSnapshot[i]['img'],
        'qty':productSnapshot[i]['qty'],
        'title':productSnapshot[i]['title'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'tprice':productSnapshot[i]['tprice']
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  //clear product means k order collection ma jatu rey atal cart mathi clear kri deva nu
  clearCart(){
    for(var i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}