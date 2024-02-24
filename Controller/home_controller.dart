import 'package:get/get.dart';

import '../consts/firebase_consts.dart';

class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }
  var navIndex=0.obs;

  var username='';

  getUsername()async{
    var n=await firestore.collection(usersCollection)
        .where("Id",isEqualTo:currentUser!.uid)
        .get()
        .then((value) {
            if(value.docs.isNotEmpty){
              return value.docs.single['name'];
            }
    });
    username=n;
    print(username);
  }

}