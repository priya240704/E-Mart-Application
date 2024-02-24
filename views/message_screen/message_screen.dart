import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/consts/firebase_consts.dart';
import 'package:emart_seller/services/store_service.dart';
import 'package:emart_seller/views/message_screen/chat_screen.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import '../../consts/string.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: darkGrey,),onPressed: (){
          Get.back();
        }),
        title: boldText(text: message,size: 16.0,color: fontGrey),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
                child: loadingIndicator());
          }else if(snapshot.data!.docs.isEmpty){
               return Center(
                   child: normalText(text: "No Messages yet.!",color: fontGrey));
          }
          else {
            var data=snapshot.data!.docs;
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                        data.length,
                          (index) {
                           var t=data[index]['created_on']==null ? DateTime.now() : data[index]['created_on'].toDate();
                           var time=intl.DateFormat("h:mma").format(t);
                               return ListTile(
                                  onTap: (){
                                 Get.to(()=>ChatScreen());
                                  },
                                 leading: CircleAvatar(
                                   backgroundColor: purpleColor,
                                   child: Icon(Icons.person,color: white,)),
                                   title: boldText(text: data[index]['sender_name'],color: fontGrey),
                                     subtitle: normalText(text: data[index]['last_msg'],color: darkGrey),
                                 trailing: normalText(text: time,color: darkGrey),
                             );
          }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
