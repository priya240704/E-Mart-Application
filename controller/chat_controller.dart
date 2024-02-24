import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/controller/home_controller.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    getchatId();
    super.onInit();
  }

  var chats=firestore.collection(chatCollection);
  var friendName=Get.arguments[0];
  var friendId=Get.arguments[1];
  var senderName=Get.find<HomeController>().username;
  var currentId=currentUser!.uid;
  var messageController=TextEditingController();
  var isLoading=false.obs;
  dynamic chatDocId;

  getchatId()async{
    isLoading(true);
    await chats.where('users',isEqualTo: {
      friendId: null,
      currentId: null
    }).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;
      }else{
        chats.add({
          "created_on":null,
          "last_msg": '',
          "users":{friendId:null,currentId:null},
          "toId":"",
          "fromId":"",
          "friend_name":friendName,
          "sender_name":senderName,
        }).then((value) {
          chatDocId=value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg)async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        "created_on": FieldValue.serverTimestamp(),
        "last_msg":msg,
        "toId":friendId,
        "fromId":currentId,
      });

      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        "created_on": FieldValue.serverTimestamp(),
        "msg":msg,
        "uid":currentId,
      });
    }
  }
}