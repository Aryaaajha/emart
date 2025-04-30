import 'package:e_commerce/views/profile_screen/profile_controller.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:e_commerce/views/profile_screen/edit_profile.dart';
import 'package:e_commerce/views/auth_screen/auth_controller.dart';
import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(backgroundColor: Constants.white,
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.redAccent),),
              );
            }
            else {
              var data = snapshot.data!.docs[0];

              return SingleChildScrollView(
                child: Padding(padding: Constants.screenPadding,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Constants.blue1,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                controller.profileImgPath.isEmpty
                                    ? CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage('assets/images/girl.jpg'),
                                )
                                    : CircleAvatar(
                                  radius: 25,
                                  backgroundImage: kIsWeb
                                      ? NetworkImage(controller.profileImgPath.value)
                                      : FileImage(File(controller.profileImgPath.value)),),
                                const SizedBox(width: 15,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text("${data['name']}",
                                        style: Constants.whiteTitleText,),
                                      const SizedBox(height: 2,),
                                      Text("${data['email']}",
                                        style: Constants.whiteSmallBodyText,)
                                    ],
                                  ),
                                ),
                                OutlinedButton(
                                    onPressed: () async {
                                      await Get.put(AuthController())
                                          .signoutMethod(context);
                                      Get.offAll(() => const LoginScreen());
                                    },
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Constants.white)
                                    ),
                                    child: Text("Logout",
                                      style: Constants.whiteSmallBodyText,)
                                ),
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                countProfile(count: "${data['cart_count']}",
                                    title: "in your cart"),
                                const SizedBox(width: 10,),
                                countProfile(count: "${data['wishlist_count']}",
                                    title: 'in your wishlist'),
                                const SizedBox(width: 10,),
                                countProfile(count: "${data['order_count']}",
                                    title: 'in your orders'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        padding: Constants.screenPadding,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              profileButtons(title: "Edit Profile",
                                  icon: Icon(Icons.edit),
                                  onTap: () {
                                    controller.nameController.text=data['name'];
                                    controller.passController.text=data['password'];
                                      Get.to(() => EditProfileScreen(data: data));
                              }),
                              profileButtons(title: "My Wallet",
                                  icon: Icon(Icons.wallet),
                                  onTap: () {}),
                              profileButtons(title: "My Orders",
                                  icon: Icon(Icons.checklist),
                                  onTap: () {}),
                              profileButtons(title: "My Wishlist",
                                  icon: Icon(Icons.favorite_border),
                                  onTap: () {}),
                              profileButtons(title: "Earned Points",
                                  icon: Icon(Icons.currency_bitcoin),
                                  onTap: () {}),
                              profileButtons(title: "Refund Requests",
                                  icon: Icon(
                                      Icons.settings_backup_restore_rounded),
                                  onTap: () {}),
                              profileButtons(title: "Messages",
                                  icon: Icon(Icons.mark_unread_chat_alt),
                                  onTap: () {}),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}

