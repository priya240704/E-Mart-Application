import 'package:emart_seller/Controller/product_controller.dart';
import 'package:emart_seller/consts/colors.dart';
import 'package:emart_seller/consts/string.dart';
import 'package:emart_seller/views/products_screen/componets/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/componets/product_images.dart';
import 'package:emart_seller/views/widget/custome_textfiled.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
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
          title: boldText(text: "Add Product", size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(
                      text: save,
                      color: Colors.white,
                    ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customeTextField(
                    hint: "eg.Smartphone",
                    label: "Product name",
                    controller: controller.pnamecontroller),
                10.heightBox,
                customeTextField(
                    hint: "eg.Complete the cellphone use the life....",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdesccontroller),
                10.heightBox,
                customeTextField(
                    hint: "eg.\$16000",
                    label: "Price",
                    controller: controller.ppricecontroller),
                10.heightBox,
                customeTextField(
                    hint: "eg.20",
                    label: "Quantity",
                    controller: controller.pquantitycontroller),
                10.heightBox,
                productDropDown("Category", controller.categorylist,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropDown("Subcategory", controller.subcategorylist,
                    controller.subCategoryValue, controller),
                10.heightBox,
                Divider(
                  color: white,
                ),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          3,
                          (index) => controller.pImagesList[index] != null
                              ? Image.file(
                                  controller.pImagesList[index],
                                  width: 100,
                                  height: 100,
                                ).onTap(() {
                                  controller.pickImage(index, context);
                                })
                              : productImage(label: "${index + 1}").onTap(() {
                                  controller.pickImage(index, context);
                                }))),
                ),
                10.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
                Divider(
                  color: white,
                ),
                10.heightBox,
                boldText(text: "Chosse product color"),
                10.heightBox,
                Obx(
                  () => Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(
                        controller.colorList.length,
                        (index) =>
                            Stack(alignment: Alignment.center, children: [
                          VxBox()
                              .color(controller.colorList[index])
                              .roundedFull
                              .size(65, 65)
                              .make()
                              .onTap(() {
                            controller.selectColorIndex.value = index;
                            print(List.generate(
                                9, (index) => Vx.randomPrimaryColor));
                          }),
                          controller.selectColorIndex.value == index
                              ? Icon(
                                  Icons.done,
                                  color: Colors.white,
                                )
                              : SizedBox()
                        ]),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
