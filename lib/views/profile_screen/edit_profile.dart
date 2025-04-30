import 'package:e_commerce/views/profile_screen/profile_controller.dart';
import 'package:e_commerce/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {

  final dynamic data;

  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final String accountName = 'emart';
  final String containerName = 'files';

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();

    return Scaffold(backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text("Edit Profile",style: Constants.blue1TitleText,),
      ),
      body: Padding(
        padding: Constants.screenPadding,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 2)
              ),
            ],
          ),
          child: Obx(()=>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [

              controller.profileImgPath.isEmpty
                ? CircleAvatar(
                radius: 45,
                  backgroundImage: AssetImage('assets/images/girl.jpg'),
                )
                    : CircleAvatar(
                radius: 45,
                backgroundImage: kIsWeb
                    ? NetworkImage(controller.profileImgPath.value)
                    : FileImage(File(controller.profileImgPath.value)),),
                SizedBox(height: 5,),
                TextButton(
                    onPressed: () async{
                      await controller.selectAndUploadFile(context);
                      },
                    child: Text("Change Photo",style: Constants.blue1SmallBodyText,)
                ),
                Divider(),
                SizedBox(height: 20,),
                customTextField(title: "Name",hintText: "Your name",isPass: false,controller: controller.nameController,),
                customTextField(title: "Password",hintText: "Password",isPass: true,controller: controller.passController,),
                SizedBox(height: 20,),
                ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.value) return; // Prevent duplicate taps
                      controller.isLoading(true);

                      await controller.updateProfile(
                        name: controller.nameController.text,
                        password: controller.passController.text,
                      );

                      controller.isLoading(false);
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Constants.blue1),
                    ),
                    child: Text("Save Changes",style: Constants.blue5SmallBodyText,)
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
