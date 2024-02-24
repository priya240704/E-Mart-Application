
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/consts/string.dart';
import 'package:shopping_app/views/auth_screen/login_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../consts/firebase_const.dart';
import '../views/home_screen/home.dart';

class AuthController extends GetxController{
  var isLoading=false.obs;
  //textcontrooler
  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context})async{
    UserCredential? userCredential;

    try{
     userCredential= await auth.signInWithEmailAndPassword(email:emailController.text,password:passwordController.text);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod(  {email,password,context})async{
    UserCredential? userCredential;

    try{
      userCredential=await auth.createUserWithEmailAndPassword(email:email,password:password);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
storeUserData({name,password,email}) async{
    DocumentReference store= firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name':name,
      'password':password,
      'email':email,
      'imageUrl':' ',
      'Id':currentUser!.uid,
      'cart_count':"00",
      'wishlist_count':"00",
      'order_count':"00",

    });
}

//signout method

  signoutMethod(context) async{
    try{
      await auth.signOut();
      Get.offAll(()=>const LoginScreen());
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }

  // void login() async {
  //   try {
  //
  //     UserCredential userCredential1 = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: emailController.text,
  //         password: passwordController.text
  //     );
  //     if (userCredential1.user!.uid == "Kopj1z2psoOFTSm3wwDieXg55L83") {
  //         Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context)=> Home1()));
  //      // Navigator.pushReplacement( MaterialPageRoute(builder: (context) => Home1(),) as BuildContext);
  //       return;
  //     }
  //     if (userCredential1.user != null) {
  //
  //       Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => Home(),));
  //       return;
  //     }
  //   }  catch (e) {
  //     print(e);
  //   }
  // }
}