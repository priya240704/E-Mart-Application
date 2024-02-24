import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/colors.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/services/firestore_services.dart';
import 'package:shopping_app/views/chat_screen/componets/sender_bubble.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controller/chat_controller.dart';
import '../../widget_common/login_indeicated.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(Colors.white).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
            ()=>
                controller.isLoading.value ? Center(
                child: loadingIndicator(),)
               : Expanded(
                  child:StreamBuilder(
                    stream: FireStoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return Center(
                          child: loadingIndicator(),
                        );
                      }else if(snapshot.data!.docs.isEmpty){
                        return Center(
                          child: "Send a message...".text.color(darkFontGrey).make(),
                        );
                      }else{
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index){
                            var data=snapshot.data!.docs[index];
                            return Align(
                              alignment: data['uid']==currentUser!.uid ? Alignment.centerRight :Alignment.centerLeft,
                                child: senderBubble(data));
                          }).toList(),
                        );
                      }
                    },
                  )
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message....",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textfieldGrey
                          )
                        )
                      ),
                    )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.messageController.text);
                  controller.messageController.clear();
                }, icon: Icon(Icons.send,color: redColor,))
              ],
            ).box.height(80).padding(EdgeInsets.all(12)).margin(EdgeInsets.all(8)).make(),
          ],
        ),
      ),
    );
  }
}
