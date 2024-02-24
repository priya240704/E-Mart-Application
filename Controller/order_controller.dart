import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var confirmed = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;

  var totalOrder = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    orderDeatils();
  }

  Future<void> orderDeatils() async {
    var aaa = StoreServices.getOrders('aa');
    await aaa.forEach((element) {
      totalOrder.value = element.docs.length;
    });
  }

  changeStatus({status, docId, title}) async {
    var store = firestore.collection(orderCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
