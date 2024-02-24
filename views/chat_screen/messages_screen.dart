import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopping_app/consts/style.dart';
import 'package:shopping_app/views/chat_screen/chat_screen.dart';
import 'package:shopping_app/widget_common/login_indeicated.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../services/firestore_services.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: " My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getAllMessages(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),);
            }else if(snapshot.data!.docs.isEmpty){
              return
                "No Messages yet!".text.color(darkFontGrey).makeCentered();
            }else{
              var data=snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child:ListView.builder(
                          itemCount: data.length,
                            itemBuilder: (BuildContext context,int index){
                            return Card(
                              child: ListTile(
                                onTap: (){
                                  Get.to(()=>ChatScreen(),
                                 arguments: [
                                   data[index]['friend_name'],
                                   data[index]['toId']
                                 ]);
                                },
                                leading: CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(Icons.person,color: whiteColor,),
                                ),
                                title: "${data[index]['friend_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                subtitle: "${data[index]['last_msg']}".text.make(),
                              ),
                            );
                          }
                          )
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
