import 'package:e_commerce/firebase_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  //text controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;

  //login method
  Future<void> loginMethod(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      if (email == "test@example.com" && password == "password123") {
        Get.snackbar("Success", "Login successful",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Invalid email or password",
            snackPosition: SnackPosition.BOTTOM);
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  //signup method
  Future<UserCredential?> signupMethod({
    required String email,
    required String password,
    required context,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException: $e");
      Fluttertoast.showToast(msg: "Error: ${e.message}");
      return null;
    }
    return userCredential;
  }

  //storing data
  storeUserData({name,email,password,imageUrl}) async{
     DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
     store.set({
       'name':name,
       'password':password,
       'email':email,
       'imageUrl': '',
       'id':currentUser!.uid,
       'cart_count':"00",
       'order_count':"00",
       'wishlist_count':"00",
     });
  }

  //signout
  signoutMethod(context)async{
    try{
      await auth.signOut();
    }
    catch(e){
      print(context);
    }
  }

}