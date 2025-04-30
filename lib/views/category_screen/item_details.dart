import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/views/category_screen/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../chat_screen/chat_screen.dart';

class ItemDetails extends StatefulWidget {
  final title;
  final dynamic data;

  const ItemDetails({super.key, this.title, this.data});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {

    int current = 0;
    var controller = Get.find<ProductController>();

    final List<String> itemDetailsButtonList = ["Video", "Reviews", "Seller Policy", "Return Policy", "Support"];
    return WillPopScope(
      onWillPop: () async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 2),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.addToCart(
                      color: widget.data['p_colors'][controller.colorIndex.value],
                      context: context,
                      img: widget.data['p_imgs'][0],
                      qty: controller.quantity.value,
                      sellername: widget.data['p_seller'],
                      title: widget.data['p_name'],
                      t_price: controller.totalPrice.value
                    );
                    Fluttertoast.showToast(msg:'Added to cart');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.redAccent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Adjust the radius here
                      ),
                    ),
                  ),
                  child: Text(
                    "Add to Cart",
                    style: Constants.whiteSmallBodyText,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.orangeAccent),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Adjust the radius here
                      ),
                    ),
                  ),
                  child: Text(
                    "Buy Now",
                    style: Constants.whiteSmallBodyText,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Constants.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
              },
            icon: Icon(Icons.arrow_back_ios),),
          backgroundColor: Constants.white,
          title: Text(widget.title.toString(),style: Constants.blackTitleText,),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.share,)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_outlined,)),
          ],
        ),
        body: Padding(
          padding: Constants.screenPadding,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.5,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          current = index;
                        });
                      },
                    ),
                    items:  (widget.data['p_imgs'] as List<dynamic>).map<Widget>((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Constants.blue4
                              ,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: (widget.data['p_imgs'] as List<dynamic>).asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          current = entry.key;
                        }),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: current == entry.key
                                ? const Color.fromRGBO(0, 0, 0, 0.9)
                                : const Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 5,),
                  Text(widget.data['p_name'],style: Constants.blue1TitleText,maxLines: 4,overflow: TextOverflow.ellipsis,),
                  const SizedBox(height: 3,),
                  SmoothStarRating(
                    allowHalfRating: true,
                    starCount: 5,
                    rating: double.tryParse(widget.data['p_rating'].toString()) ?? 0.0,
                    size: 25.0,
                    color: Colors.orange[400],
                    borderColor: Colors.orange[400],
                  ),
                  const SizedBox(height: 3,),
                  Text(widget.data['p_price'],style: Constants.blackTitleText,textAlign: TextAlign.left,),
                  const SizedBox(height: 5,),
                  Container (
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.blue1,
                    ),
                    child: Row(
                      children: [
                        Text(widget.data['p_seller'],style: GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w600,color: Constants.white)),
                        const Spacer(),
                        IconButton(
                          iconSize: 17,
                          color: Constants.white,
                          icon: Icon(Icons.message_rounded,color: Constants.white,),
                          onPressed: (){
                            Get.to(()=>ChatScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1), // Shadow color with opacity
                          spreadRadius: 1, // Spread radius
                          blurRadius: 2,   // Blur radius
                          offset: const Offset(1, 1),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Obx(()=>
                        Column(
                          children: [
                            Padding(padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text("Color: ",style: Constants.blackBodyText ,),
                                  ),
                                  Row(
                                    children: List.generate(widget.data['p_colors'].length,
                                            (index)=> Stack(alignment: Alignment.center,
                                              children:[
                                                GestureDetector(
                                                  onTap:(){},
                                                  child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                                  child: CircleAvatar(backgroundColor: Color(widget.data['p_colors'][index]).withOpacity(1.0),),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: index == controller.colorIndex.value,
                                                    child: Icon(Icons.done,color: Colors.white,)
                                                )
                                              ]
                                            )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(padding: const EdgeInsets.all(5),
                              child:
                                 Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text("Quantity: ",style: Constants.blackBodyText ,),
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          controller.decreaseQuantity();
                                          controller.calculateTotalPrice(int.parse(widget.data['p_price']));
                                          },
                                        icon:const Icon(Icons.remove)
                                    ),
                                    Text(controller.quantity.value.toString(),style: Constants.blackBodyText,),
                                    IconButton(
                                        onPressed: (){
                                          controller.increaseQuantity(int.parse(widget.data['p_quantity']));
                                          controller.calculateTotalPrice(int.parse(widget.data['p_price']));
                                          },
                                        icon:const Icon(Icons.add)
                                    ),
                                    const SizedBox(width: 5,),
                                    Text("${widget.data['p_quantity']} available",style: Constants.blackSmallBodyText,)
                                  ],
                                ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Constants.blue1,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text("Total Price: ",style:GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w600,color: Constants.white),),
                                  ),
                                  Text(controller.totalPrice.value?.toString() ?? "0",style:GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w600,color: Constants.white),)

                                ],
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text("Description",style: Constants.blackBodyText,),
                  const SizedBox(height: 5,),
                  Text(widget.data['p_desc'],style: Constants.blackSmallBodyText,),
                  const SizedBox(height: 5,),
                  ListView(
                    shrinkWrap: true,
                    children: List<Widget>.generate(
                      itemDetailsButtonList.length,
                          (index) => Column(
                            children: [
                              ListTile(
                                title: Text(itemDetailsButtonList[index],
                                  style: Constants.blackBodyText,
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                              ),
                              const SizedBox(height: 5,),
                            ],
                          ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.blue1,
                    ),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft ,child: Text("Products you may also like",style: Constants.whiteTitleText,)),
                        const SizedBox(height: 8,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(2,(index)=>
                            const Row(
                              children: [
                                featuredButtons(img: 'assets/images/girl.jpg', text: "Analog Black Dial Men's Watch", price: "₹600.00"),
                                SizedBox(width: 10,),
                                featuredButtons(img: 'assets/images/girl.jpg', text: "Analog Black Dial Men's Watch", price: " ₹600.00"),
                                SizedBox(width: 10,),
                              ],)
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
