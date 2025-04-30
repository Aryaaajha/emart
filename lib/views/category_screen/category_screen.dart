import 'package:e_commerce/constants.dart';
import 'package:e_commerce/views/category_screen/category_details.dart';
import 'package:e_commerce/views/category_screen/product_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const categoryList = ['Women Clothing', 'Men Clothing','PC Accessories','Automobile', 'Kids Section ','Sports','Jewellery', 'Mobile & Tablets','Furniture'];
  static const categoryImgs = ['assets/images/girl_3.jpg', 'assets/images/men.jpg','assets/images/computer.jpg','assets/images/automobile.jpeg', 'assets/images/kids.jpg','assets/images/sports.jpg','assets/images/jewellery.jpg', 'assets/images/phone.jpg','assets/images/furniture.jpg'];

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return SingleChildScrollView(
      child: Container(
        color: Constants.white,
        padding: Constants.screenPadding,
        child: GridView.builder(
          shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              mainAxisExtent: 180,
            ),
            itemBuilder: (context,index){
              return GestureDetector(
                onTap: (){
                  controller.getSubCategories(categoryList[index]);
                  Get.to(()=>CategoryDetails(title: categoryList[index]));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.secondarySystemGroupedBackground,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(categoryImgs[index],height: 120,width: 200,fit: BoxFit.cover,),
                      const SizedBox(height: 10,),
                      Text(categoryList[index],
                        style: GoogleFonts.montserrat(fontSize: 12,fontWeight: FontWeight.w400,color: Constants.blue1),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
