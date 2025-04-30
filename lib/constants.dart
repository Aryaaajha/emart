import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/home_screen/home_controller.dart';

class Constants{
  static Color blue1 = const Color(0xFF00296B);
  static Color blue2 = const Color(0xFF0077B6);
  static Color blue3 = const Color(0xFF00B4D8);
  static Color blue4 = const Color(0xFF90E0EF);
  static Color blue5 = const Color(0xFFCAF0F8);
  static Color white = const Color(0xFFF5F5FA);
  static Color black = const Color(0xFF1F1F29);

  static TextStyle blue1BodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.blue1);
  static TextStyle blue1TitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.blue1);
  static TextStyle blue1SmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.blue1);

  static TextStyle blue2BodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.blue2);
  static TextStyle blue2TitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.blue2);
  static TextStyle blue2SmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.blue2);

  static TextStyle blue3BodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.blue3);
  static TextStyle blue3TitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.blue3);
  static TextStyle blue3SmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.blue3);

  static TextStyle blue4BodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.blue4);
  static TextStyle blue4TitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.blue4);
  static TextStyle blue4SmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.blue4);

  static TextStyle blue5BodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.blue5);
  static TextStyle blue5TitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.blue5);
  static TextStyle blue5SmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.blue5);

  static TextStyle whiteBodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.white);
  static TextStyle whiteTitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.white);
  static TextStyle whiteSmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.white);

  static TextStyle blackBodyText = GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500,color: Constants.black);
  static TextStyle blackTitleText = GoogleFonts.montserrat(fontSize: 17,fontWeight: FontWeight.w700,color: Constants.black);
  static TextStyle blackSmallBodyText = GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w400,color: Constants.black);

  static EdgeInsets screenPadding = const EdgeInsets.all(20);

}
class appLogo extends StatelessWidget {
  final size;
  const appLogo({super.key, this.size});


  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(5),
        color: Constants.white,
      ),
      child:
      Icon(Icons.shopping_bag_rounded,
        color: Constants.blue2,
        size: size,
      ),
    );
  }
}

class customTextField extends StatelessWidget {

  final String title;
  final String? hintText;
  final controller;
  final isPass;

  const customTextField({super.key, required this.title, this.hintText, this.controller, this.isPass});

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        Align(alignment:Alignment.centerLeft,child: Text(title,style: Constants.blue1BodyText,)),
        const SizedBox(height: 5,),
        TextFormField(
          obscureText: isPass,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Constants.blue1SmallBodyText,
            isDense: true,
            fillColor: Constants.white,
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide(color: Constants.blue1))
          ),
        ),
        const SizedBox(height: 5,),
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  final NavController controller;

  NavBar({super.key, required this.controller});

  final List<Widget> pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Grid View Page")),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Cart Page")),
    const Center(child: Text("Profile Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CurvedNavigationBar(
            index: controller.currentIndex.value,
            backgroundColor: Colors.transparent,
            height: 65,
            color: Constants.blue1,
            buttonBackgroundColor: Constants.blue1,
            items: <Widget>[
              Icon(
                Icons.home,
                size: 30,
                color: Colors.grey[300],
              ),

              Icon(Icons.grid_view_rounded, size: 30,color:Colors.grey[300],),
              Icon(Icons.search, size: 30,color: Colors.grey[300]),
              Icon(Icons.shopping_cart, size: 30,color: Colors.grey[300]),
              Icon(Icons.person, size: 30,color: Colors.grey[300]),
            ],
            onTap: (index) {
              controller.changePage(index);
            },
      ),
    );
  }
}

class homeButtons extends StatelessWidget {
  const homeButtons({super.key, this.icon, required this.text, this.iconcolor});

  final icon;
  final iconcolor;
  final text;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        child: Column(
          children: [
            Icon(icon,color: iconcolor,),
            const SizedBox(height: 5,),
            Text(text,style: Constants.blackBodyText,),
          ],
        ),
      ),
    );
  }
}

class categoryButtons extends StatelessWidget {
  const categoryButtons({super.key, this.img, required this.text});

  final img;
  final text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white
      ),
      child: Row(
        children: [
          Image.asset(width: 70,height: 50,img,fit: BoxFit.cover,),
          const SizedBox(width: 5,),
          Text(text,style: Constants.blackSmallBodyText,),
        ],
      )
    );
  }
}

class featuredButtons extends StatelessWidget {
  const featuredButtons({super.key, required this.img, required this.text, required this.price});

  final String img;
  final String text;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
      child: Column(
        children: [
          Image.asset(img,fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width * 0.356,
            height: MediaQuery.of(context).size.height * 0.29,
          ),
          const SizedBox(height: 5,),
          Text(text,style: GoogleFonts.montserrat(fontSize: 10,fontWeight: FontWeight.w700,color: Constants.black),overflow: TextOverflow.ellipsis,),
          const SizedBox(height: 5,),
          Text(price,style: Constants.blue1BodyText,),
        ]
      ),
    );
  }
}

class profileButtons extends StatelessWidget {
  const profileButtons({Key? key, required this.title, required this.icon, required this.onTap}) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 10,),
                Text(title,style: Constants.blackBodyText,)
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class countProfile extends StatelessWidget {
  const countProfile({Key? key, required this.count, required this.title}) : super(key: key);

  final String count;
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(count,style: Constants.blackBodyText,),
          const SizedBox(height:5,),
          Text(title,style: Constants.blackSmallBodyText,)
        ],
      ),
    );
  }
}







