import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/consts/firebase_consts.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(usersCollection)
        .where("Id", isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getOrders(uid) {
    return firestore
        .collection(orderCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        .snapshots();
  }

  // static getProduct(uid) {
  //   return firestore
  //       .collection(productsCollection)
  //       .where("vendor_id", isEqualTo: currentUser!.uid)
  //       .snapshots();
  // }

  static getProduct(uid) {
    return firestore.collection(productsCollection).snapshots();
  }
}
