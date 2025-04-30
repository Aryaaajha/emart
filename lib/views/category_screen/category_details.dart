import 'package:e_commerce/constants.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/views/category_screen/item_details.dart';
import 'package:e_commerce/views/category_screen/product_controller.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDetails extends StatelessWidget {
  const CategoryDetails({super.key, this.title});

  final title;

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    return Scaffold(backgroundColor: Constants.white,
      appBar: AppBar(backgroundColor: Constants.blue5,
        title: Text(title, style: Constants.blue1TitleText,),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text("No products found!"),
              );
            }
            else {
              var data = snapshot.data!.docs;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children:
                        List.generate(controller.subcat.length,
                                (index) =>
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      padding: Constants.screenPadding,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        controller.subcat[index],
                                        style: Constants.blue1SmallBodyText,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                  ),
                                )
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: GestureDetector(
                                onTap: () {
                                  print("Navigating to ItemDetails with title: ${data[index]['p_name'].toString()}");
                                  print("Data: ${data[index]}");
                                  print("Data content: ${data[index].data()}");
                                  Get.to(() => ItemDetails(title: data[index]['p_name'],data: data[index].data(),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Image.network(data[index]['p_imgs'][0],
                                          fit: BoxFit.cover,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.3,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.1,
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(data[index]['p_name'],
                                          style: GoogleFonts.montserrat(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Constants.black),
                                          overflow: TextOverflow.ellipsis,),
                                        const SizedBox(height: 5,),
                                        Text(data[index]['p_price'],
                                          style: Constants.blue1BodyText,),
                                      ]
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    )
                  ],
                ),
              );
            }
          }
      )
    );
  }
}
