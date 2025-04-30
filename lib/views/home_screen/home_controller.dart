import 'package:e_commerce/firebase_consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  final PageController pageController = PageController();

  void changePage(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

}

class HomeController extends GetxController{

  @override
  void onInit(){
    getUsername();
    super.onInit();
  }
  var username ='';

  getUsername()async{
    var n = await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value){
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username=n;
  }
}