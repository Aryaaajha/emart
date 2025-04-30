import 'package:e_commerce/views/auth_screen/auth_controller.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/views/auth_screen/signup_screen.dart';
import 'package:e_commerce/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.blue1,
      body: Padding(padding: Constants.screenPadding,
        child: Align(alignment: Alignment.center,
          child:
          Column(
            children: [
              appLogo(size: MediaQuery.of(context).size.width * 0.09),
              const SizedBox(height: 30,),
              Text('Log-In to eMart',style: Constants.whiteBodyText,),
              const SizedBox(height: 5,),
              Container(
                padding: Constants.screenPadding,
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.white,
                ),
                child: Obx(()=>
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        customTextField(title: 'Email',hintText: 'abc@gmail.com',isPass: false,controller: emailController,),
                        const SizedBox(height: 5,),
                        customTextField(title: 'Password',hintText: 'password',isPass: true,controller: passwordController,),
                        Align(alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: (){},
                              child: Text('Forgot Password?',
                                  style: TextStyle(color: Constants.blue2,fontSize: 10,)
                              ),
                            )
                        ),
                        controller.isLoading.value
                            ? Center(
                              child: SizedBox(height: 20,width: 20,
                                child: CircularProgressIndicator(
                                  color: Constants.blue1,),
                              ),)
                            : ElevatedButton(
                              onPressed: () {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                controller.loginMethod(email, password);
                                print(email);
                                print(password);
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(Constants.blue5),
                              ),
                            child: Text("Log in",style: Constants.blue1SmallBodyText,)
                        ),
                        const SizedBox(height: 15,),
                        Text('or create a new account',style: Constants.blackSmallBodyText,textAlign: TextAlign.center,),
                        const SizedBox(height: 15,),
                        ElevatedButton(
                            onPressed: (){
                              Get.to(()=>const SignupScreen());
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(Constants.blue1),
                            ),
                            child: Text("Sign up",style: Constants.blue5SmallBodyText,)
                        ),
                        const SizedBox(height: 3,),
                        Text('Login with',style: Constants.blackSmallBodyText,textAlign: TextAlign.center,),
                        const SizedBox(height: 3,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue), // Feather icon for falcon-like representation
                              onPressed: () {
                                // Action for the Falcon icon button
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                              onPressed: () {
                                // Action for the Google icon button
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.blue),
                              onPressed: () {
                                // Action for the Twitter icon button
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
