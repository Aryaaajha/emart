import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var subcat = <String>[];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  getSubCategories(title) async{

    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element)=> element.name == title).toList();

    for(var e in s[0].subcategory){
      subcat.add(e);
    }

  }

  changeColorIndex(index){
    colorIndex.value= index;
  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity(){
    if(quantity.value>0) {
      quantity.value--;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price* quantity.value;
  }
  
  addToCart({title,img, sellername, color, qty, t_price, required BuildContext context, }) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'color': color,
      'qty': qty,
      'tprice': t_price.toString(),
      'added_by': currentUser!.uid,
    }).catchError((error) {
      Fluttertoast.showToast(msg: error.toString());
    });
  }
    resetValues(){
      totalPrice.value=0;
      quantity.value=0;
      colorIndex.value=0;
    }
}