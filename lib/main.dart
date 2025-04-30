import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/views/auth_screen/signup_screen.dart';
import 'package:e_commerce/views/cart_screen/cart_screen.dart';
import 'package:e_commerce/views/category_screen/category_details.dart';
import 'package:e_commerce/views/category_screen/category_screen.dart';
import 'package:e_commerce/views/category_screen/item_details.dart';
import 'package:e_commerce/views/profile_screen/edit_profile.dart';
import 'package:e_commerce/views/profile_screen/profile_screen.dart';
import 'package:e_commerce/views/search_screen/search_screen.dart';
import 'package:e_commerce/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/chat_screen/chat_screen.dart';
import 'views/home_screen/home.dart';
import 'views/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCSTtKKctS5X4ngb4RucZpL8Tnmv1XGgvw",
          authDomain: "emart-48b08.firebaseapp.com",
          projectId: "emart-48b08",
          storageBucket: "emart-48b08.appspot.com",
          messagingSenderId: "102107180510",
          appId: "1:102107180510:web:29ad21b32bdbd9d845414f",
          measurementId: "G-E9YN68YHR3"
      ),
    );
  } else {
    // Initialize Firebase for other platforms (iOS, Android)
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce app',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent)
      ),
      home: const SplashScreen(),
      initialRoute: '/splashscreen',
      routes: {
        '/splashscreen': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const Home(),
        '/home-screen': (context) => const HomeScreen(),
        '/category': (context) => const CategoryScreen(),
        '/categorydetails': (context) => const CategoryDetails(),
        '/item': (context) => const ItemDetails(),
        '/search': (context) => const SearchScreen(),
        '/cart': (context) => const CartScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/editprofile': (context) => const EditProfileScreen(),
        '/chat': (context) => const ChatScreen(),

      }
    );
  }
}

