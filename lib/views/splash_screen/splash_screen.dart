import 'package:e_commerce/constants.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../auth_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

   @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  changeScreen(){
    Future.delayed(const Duration(seconds: 3),(){
      // Get.to(()=>const LoginScreen());

      auth.authStateChanges().listen((User? user){
        if(user ==  null && mounted){
          Get.to(()=>const LoginScreen());
        }
        else{
          Get.to(()=>const Home());
        }
      });
    });
  }

  @override
  void initState(){
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blue1,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appLogo(size: MediaQuery.of(context).size.width * 0.09),
            const SizedBox(height: 7,),
            Text("eMart",style: GoogleFonts.montserrat(fontSize: 30,fontWeight: FontWeight.w400,color: Constants.white)),
            Text("Version 1.0.0",style: Constants.whiteSmallBodyText,),
          ],
        ),
      ),
    );
  }
}


