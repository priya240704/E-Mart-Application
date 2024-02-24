import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../consts/firebase_consts.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  //textcontrooler
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method
  // storeUserData({name,password,email}) async{
  //   DocumentReference store= firestore.collection(vendorCollection).doc(currentUser!.uid);
  //   store.set({
  //     'vendor_name':name,
  //     'password':password,
  //     'email':email,
  //     'imageUrl':' ',
  //     'id':currentUser!.uid,
  //   });
  // }

//signout method

  signoutMethod(context) async {
    try {
      await auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
