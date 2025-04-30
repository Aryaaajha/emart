import 'package:e_commerce/constants.dart';
import 'package:e_commerce/views/cart_screen/cart_screen.dart';
import 'package:e_commerce/views/category_screen/category_screen.dart';
import 'package:e_commerce/views/home_screen/home_controller.dart';
import 'package:e_commerce/views/home_screen/home_screen.dart';
import 'package:e_commerce/views/profile_screen/profile_screen.dart';
import 'package:e_commerce/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NavController());

    final List<Widget> pages = [
      const HomeScreen(),
      const CategoryScreen(),
      const SearchScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text('eMart',
                style: GoogleFonts.montserrat(
                fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[300]
                )
            )
        ),
          flexibleSpace: ClipPath(
          clipper: CustomShape(),
          child: Container(
            color: Constants.blue1,
          ),
        )
      ),
      backgroundColor: Constants.white,
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          controller.currentIndex.value = index;
        },
        children: pages,
      ),
      bottomNavigationBar: NavBar(controller: controller),
    );
  }
}
class CustomShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}



