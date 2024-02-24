import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopping_app/consts/firebase_const.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex=0.obs;

  var username='';

  var searchController=TextEditingController();

  //chatting funaction
  getUsername()async{
    var n =await firestore.collection(usersCollection).where('Id',isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username=n;
  }

  //
}