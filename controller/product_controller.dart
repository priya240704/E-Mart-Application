import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/model/category_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController{
  var subcat=[];
  var quantity=0.obs;
  var colorIndex=0.obs;
  var totalPrice=0.obs;
  var isFav=false.obs;
  //function create karva nu json file banvii enu

  getSubCategories(title) async{
    subcat.clear();
    var data =await rootBundle.loadString("lib/services/category_model.json");
    var decoded=categoryModelFromJson(data);
    var s=decoded.categories.where((element) => element.name==title).toList();

   for(var e in s[0].subcategories){
     subcat.add(e);
   }
  }
  changeColorIndex(index){
    colorIndex.value=index;
  }

  incressQuantity(totalQuantity){
    if(quantity.value <totalQuantity){
      quantity.value++;
    }
  }

  descressQuantity(){
    if(quantity.value  > 0){
      quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value=price*quantity.value;
  }
  
  addToCart({
    title,
    img,
    sellername,
    color,
    qty,
    tprice,
   vendorId,
    context,

})async{
    await firestore.collection(cartCollection).doc().set({
      'title':title,
      'img':img,
      'sellername':sellername,
      'color':color,
      'qty':qty,
      'tprice':tprice,
      'vendor_id':vendorId,
      'added_by': currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value=0;
    quantity.value=0;
    colorIndex.value=0;
    isFav.value=false;
  }

//wishlist
  addtoWishlist(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([
        currentUser!.uid
      ])
    },SetOptions(merge:true));
    isFav(true);
    VxToast.show(context, msg: "Added wishlist");
  }

  removeFromWishlist(docId,context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([
        currentUser!.uid
      ])
    },SetOptions(merge:true));
    isFav(false);
    VxToast.show(context, msg: "Removed wishlist");
  }

  checkIfFav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
  }
}