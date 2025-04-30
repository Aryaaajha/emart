import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final List<String> images = [
      'assets/images/girl.jpg',
      'assets/images/clothes.jpg',
      'assets/images/girl_2.jpeg',
    ];

    return SingleChildScrollView(
      child: Container(
          color: Constants.white,
          padding: Constants.screenPadding,
          //width: MediaQuery.of(context).size.width,
          //height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child:Column(
                children: [
                  CarouselSlider (
                    options: CarouselOptions(
                    height: 100.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: images.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Constants.blue4,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
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
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      homeButtons(
                        text: "Today's Deal",
                        icon: Icons.today_outlined,
                        iconcolor: Colors.redAccent,
                      ),
                      SizedBox(width: 30,),
                      homeButtons(
                        text: "Flash Sale",
                        icon: Icons.electric_bolt_outlined,
                        iconcolor: Colors.orangeAccent,
                      )
      
                    ],
                  ),
                  const SizedBox(height: 10,),
                  CarouselSlider (
                    options: CarouselOptions(
                      height: 150.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      autoPlayInterval: const Duration(seconds: 4),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: images.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Constants.blue4,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
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
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      homeButtons(
                        text: "Categories",
                        icon: Icons.grid_view,
                        iconcolor: Colors.redAccent,
                      ),
                      SizedBox(width: 30,),
                      homeButtons(
                        text: "Brands",
                        icon: Icons.tips_and_updates_outlined,
                        iconcolor: Colors.blue,
                      ),
                      SizedBox(width: 30,),
                      homeButtons(
                        text: "Top Sellers",
                        icon: Icons.star_rate_outlined,
                        iconcolor: Colors.orangeAccent,
                      )
      
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Align(alignment: Alignment.centerLeft,
                      child: Text("Featured Categories",
                        style: Constants.blackTitleText,)
                  ),
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(2,(index)=>
                            const Row(
                              children: [
                                categoryButtons(img: 'assets/images/men.jpg',text: 'Men Clothing',),
                                SizedBox(width: 10,),
                                categoryButtons(img: 'assets/images/girl_3.jpg',text: 'Women Clothing',),
                                SizedBox(width: 10,),
                            ],)
                    ),
                      ),
                    ),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Constants.blue1,
                    ),
                    child: Column(
                      children: [
                        Align(alignment: Alignment.centerLeft ,child: Text("Featured Products",style: Constants.whiteTitleText,)),
                        const SizedBox(height: 8,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(2,(index)=>
                            const Row(
                              children: [
                                featuredButtons(img: 'assets/images/girl_3.jpg', text: "Analog Black Dial Men's Watch", price: "₹600.00"),
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
                  const SizedBox(height: 10,),
                  CarouselSlider (
                    options: CarouselOptions(
                      height: 65.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      autoPlayInterval: const Duration(seconds: 6),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                    items: images.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Constants.blue4,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
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
                  //5th video
                 ],
              )
          ),
        ),
    );
  }
}
