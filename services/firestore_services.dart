import 'package:shopping_app/consts/firebase_const.dart';
import 'package:shopping_app/consts/string.dart';

//get user data
class FireStoreServices{
  static getUser(uid){
    return firestore.collection(usersCollection).where('Id',isEqualTo: uid).snapshots();
  }

  // get product according to category

static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
}

  static getSubCategoryProduct(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo: title).snapshots();
  }

//get cart
static getCart(uid){
    return firestore.collection(cartCollection).where("added_by",isEqualTo: uid).snapshots();
}

//delele document
static deleteDocument(docID){
    return firestore.collection(cartCollection).doc(docID).delete();
}

//get all chqt msg
static getChatMessages(docID){
    return firestore
        .collection(chatCollection)
        .doc(docID)
        .collection(messagesCollection)
        .orderBy("created_on",descending: false)
        .snapshots();
}

static getAllOrders(){
    return firestore.collection(orderCollection).where('order_by',isEqualTo:currentUser!.uid).snapshots();
}

static getwishlist(){
    return firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
}

static getAllMessages(){
    return firestore.collection(chatCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
}

static getCounts()async{
    var res=Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo: currentUser!.uid).get().then((value){
       return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(orderCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
    ]);
    return res;
}

//homescreen
static allproduct(){
    return firestore.collection(productsCollection).snapshots();
}

//get feature product method home screen
static getFeaturePRoducts(){
    return firestore.collection(productsCollection).where("is_featured",isEqualTo: true).get();
}

//seacrh product
static seacrhProducts(title){
    return firestore.collection(productsCollection).get();
}


}