import 'package:emart_seller/views/message_screen/componets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../consts/colors.dart';
import '../../consts/string.dart';
import '../widget/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: darkGrey,),onPressed: (){
          Get.back();
        }),
        title: boldText(text: chat,size: 16.0,color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  itemCount: 20,
                    itemBuilder: ((context,index){
                  return chatBubble();
                }))
            ),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                        hintText: "Enter message..",
                        border:OutlineInputBorder(
                      borderSide: BorderSide(color: purpleColor)
                    ),
                      focusedBorder:OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor)
                      )
                    ),
                  )),
                  IconButton(onPressed: (){}, icon: Icon(Icons.send,color: purpleColor,))
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
