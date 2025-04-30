import 'package:e_commerce/views/auth_screen/auth_controller.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/views/home_screen/home.dart';
import 'package:e_commerce/views/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool isChecked = false;
  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    //text controllers
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var passwordRetypeController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Constants.blue1,
      body: Padding(padding: Constants.screenPadding,
        child: Align(alignment: Alignment.center,
          child: Column(
            children: [
              appLogo(size: MediaQuery.of(context).size.width * 0.09),
              const SizedBox(height: 30,),
              Text('Sign-up to eMart',style: Constants.whiteBodyText,),
              const SizedBox(height: 5,),
              Container(
                padding: Constants.screenPadding,
                height: MediaQuery.of(context).size.height * 0.67,
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.white,
                ),
                child: Obx(()=>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      customTextField(title: 'Name',hintText: 'Enter your name',controller: nameController,isPass: false),
                      customTextField(title: 'Email',hintText: 'Enter your email id',controller: emailController,isPass: false),
                      const SizedBox(height: 3,),
                      customTextField(title: 'Password',hintText: 'Enter password',controller: passwordController,isPass: true,),
                      customTextField(title: 'Retype password',hintText: 'Retype password',controller: passwordRetypeController,isPass: true,),
                      Align(alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: (){},
                            child: Text('or register with a phone number', style: Constants.blue2SmallBodyText),
                          )
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            checkColor: Constants.blue5,
                            activeColor: Constants.blue1,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Expanded(child: Text('I agree to the Terms & Conditions',style: Constants.blackSmallBodyText,overflow: TextOverflow.ellipsis,maxLines: 1,)),
                        ],
                      ),
                      const SizedBox(height: 5,),
                      controller.isLoading.value
                      ? Center(
                        child: CircularProgressIndicator(
                          color: Constants.blue1,
                        ),
                      )
                      : ElevatedButton(onPressed: ()async{
                        if(isChecked!=false){
                          controller.isLoading(true);
                          try{
                            await controller.signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text
                            ).then((value){
                              return controller.storeUserData(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text
                              );
                            }).then((value){
                              Fluttertoast.showToast(msg:"Logged In Successfully");
                              Get.offAllNamed('/home');
                            });
                          }
                          catch(e){
                            auth.signOut();
                            print(e);
                            Fluttertoast.showToast(msg: "Sign Up Failed: ${e.toString()}");
                            controller.isLoading(false);
                          }
                        }
                      },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(isChecked==true? Constants.blue1 : CupertinoColors.inactiveGray),
                          ),
                          child: Text("Sign up",style: isChecked==true? Constants.blue5SmallBodyText : Constants.blackSmallBodyText,)
                      ),
                      const SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?',style: Constants.blackSmallBodyText),
                          TextButton(
                            onPressed: (){
                              Get.to(()=>const LoginScreen());
                            },
                            child: Text('Log in', style: Constants.blue2SmallBodyText),
                          )
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
