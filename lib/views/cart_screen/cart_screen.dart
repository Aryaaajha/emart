import 'package:e_commerce/constants.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/cart_screen/cart_controller.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context){

    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Constants.white,
      body: StreamBuilder(stream: FirestoreServices.getCart(currentUser!.uid),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text("Cart is empty"),
              );
            }
            else{
              var data = snapshot.data!.docs;
              controller.calculate(data);
              return Padding(
                padding: Constants.screenPadding,
                child: Column(
                  children: [
                    Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: data.length,
                              itemBuilder: (BuildContext context, int index){
                                return ListTile(
                                  leading: Image.network("${data[index]['img']}"),
                                  title: Text("${data[index]['title']} x ${data[index]['qty']}",style: Constants.blackBodyText,),
                                  subtitle:Text(data[index]['tprice'],style: Constants.blue1BodyText,),
                                  trailing: IconButton(icon:Icon(Icons.delete,color: Colors.redAccent,),
                                    onPressed: (){
                                    FirestoreServices.deleteDocument(data[index].id);
                                    },
                                  ),
                                );

                              }
                          ),
                        )
                    ),
                    Spacer(),
                    Container(color: Constants.white,
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Total Price:",style: Constants.blue1TitleText,),
                            SizedBox(width: 20,),
                            Obx(()=> Text("${controller.totalP.value}",style: Constants.blackTitleText,)),
                            Spacer(),
                            CircleAvatar(backgroundColor: Constants.blue1,
                              child:IconButton(color:Constants.blue1, icon:Icon(Icons.arrow_forward,color: Constants.white,),onPressed: (){},),
                            ),
                            // ),
                          ],
                        )),
                  ],
                ),
              );
            }
      }
        ),
    );
  }
}
