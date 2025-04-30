import 'dart:io';

import 'package:e_commerce/firebase_consts.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreServices{
  
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();

  }

  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo: category).snapshots();
  }

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
}