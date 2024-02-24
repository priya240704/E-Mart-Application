import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../consts/images.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  autoPlay: true,
                  itemCount: data['p_imgs'].length,
                  height: 350,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemBuilder: (context, index) {
                    return Image.network(
                      data['p_imgs'][index],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
              10.heightBox,
              //title and details section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(
                        text: "${data['p_name']}", color: fontGrey, size: 16.0),
                    //title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(
                            text: "${data['p_category']}",
                            color: fontGrey,
                            size: 16.0),
                        10.widthBox,
                        normalText(
                            text: "${data['p_subcategory']}",
                            color: fontGrey,
                            size: 16.0)
                      ],
                    ),
                    10.heightBox,
                    //rating
                    VxRating(
                      isSelectable: false,
                      value: double.parse("${data['p_rating']}"),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      size: 25,
                      maxRating: 5,
                      count: 5,
                    ),
                    10.heightBox,
                    boldText(
                        text: "${data['p_price']}", color: red, size: 18.0),
                    //"${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Colors", color: fontGrey),
                              //  child: "Color:".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                data['p_colors'].length,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Color(data['p_colors'][index]))
                                    .margin(EdgeInsets.symmetric(horizontal: 6))
                                    .make()
                                    .onTap(() {
                                  //  controller.changeColorIndex(index);
                                }),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        //Quantity Row
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  normalText(text: "Quantity", color: fontGrey),
                            ),
                            normalText(
                                text: "${data['p_quantity']} items ",
                                color: fontGrey),
                          ],
                        )
                      ],
                    ).box.padding(EdgeInsets.all(8)).white.make(),
                    Divider(),
                    20.heightBox,
                    boldText(text: "Description", color: fontGrey),
                    10.heightBox,
                    normalText(text: "${data['p_desc']}", color: fontGrey)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
