import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/Controller/home_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import '../consts/firebase_consts.dart';
import '../models/category_model.dart';
import 'dart:io';
import 'package:path/path.dart';

class ProductsController extends GetxController {
  var isLoading = false.obs;
  // text flied controller
  var pnamecontroller = TextEditingController();
  var pdesccontroller = TextEditingController();
  var ppricecontroller = TextEditingController();
  var pquantitycontroller = TextEditingController();

  var categorylist = <String>[].obs;
  var subcategorylist = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
  var selectColorIndex = 0.obs;

  List<Color> colorList = [
    Color(0xff009688),
    Color(0xffffeb3b),
    Color(0xff673ab7),
    Color(0xff9c27b0),
    Color(0xff4caf50),
    Color(0xff795548),
    Color(0xff00bcd4),
    Color(0xff607d8b),
    Color(0xffff5722),
  ];

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoriList() {
    categorylist.clear();
    for (var item in category) {
      categorylist.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subcategorylist.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategories.length; i++) {
      subcategorylist.add(data.first.subcategories[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'image/vendors/${currentUser!.uid}/$filename';

        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_colors':
          FieldValue.arrayUnion([colorList[selectColorIndex.value].value]),
      'p_desc': pdesccontroller.text,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_name': pnamecontroller.text,
      'p_price': ppricecontroller.text,
      'p_quantity': pquantitycontroller.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isLoading(false);
    VxToast.show(context, msg: "Product upload");
  }

  //addfeatred
  addFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  //removefeatured
  removeFeatured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'featured_id': '',
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  //remove product
  removeProduct(docID) async {
    await firestore.collection(productsCollection).doc(docID).delete();
  }
}
