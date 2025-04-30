import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:e_commerce/firebase_consts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class ProfileController extends GetxController {
  RxString profileImgPath = ''.obs;
  RxBool isLoading = false.obs;

  // Text fields
  var nameController = TextEditingController();
  var passController = TextEditingController();

  // Azure storage constants
  final storageBaseUri = 'https://emart.blob.core.windows.net';
  final sasToken = '?se=2025-11-26&sp=rwd&spr=https&sv=2022-11-02&sr=c&sig=8uw1nSzZT4R3MQAwuPqXCP9ZRAoJ398P2GjQ8JPCHHc%3D';
  final containerName = 'files';

  Future<void> selectAndUploadFile(context) async {
    // Step 1: Select the file
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) {
      print('No file selected.');
      return;
    }

    // Store the file details
    final filePickerResult = result.files.first;

    // Step 2: Upload the file
    if (filePickerResult.bytes == null) {
      print('No file selected for upload.');
      return;
    }

    final fileName = filePickerResult.name.replaceAll(' ', '_');
    final fileBytes = filePickerResult.bytes!;
    final containerName = 'files'; // Ensure container name is correct

    // Define the base URI and SAS token
    final storageBaseUri = 'https://emart.blob.core.windows.net';
    final sasToken = '?se=2025-11-26&sp=rwd&spr=https&sv=2022-11-02&sr=c&sig=8uw1nSzZT4R3MQAwuPqXCP9ZRAoJ398P2GjQ8JPCHHc%3D';

    // Full blob destination path (container + filename)
    final blobUri = '$storageBaseUri/$containerName/$fileName$sasToken';

    try {
      print('Uploading file: $fileName to Azure Blob Storage...');

      // Create a PUT request directly using http
      final uri = Uri.parse('$storageBaseUri/$containerName/$fileName$sasToken');
      final response = await http.put(
        uri,
        headers: {
          'x-ms-blob-type': 'BlockBlob', // Required header for blob type
          'Content-Type': 'application/octet-stream', // Optional: File MIME type
        },
        body: fileBytes,
      );

      if (response.statusCode == 201) {
        print('File uploaded successfully!');
        print('Public URL: ${uri.toString()}');

        profileImgPath.value = '$storageBaseUri/$containerName/$fileName';

        // Call updateProfile with the public URL
        await updateProfile(
          imgUrl: profileImgPath.value
        );
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Upload error: $e');
    }
  }


  Future<void> updateProfile({String? name, String? password, String? imgUrl,}) async {
    try {
      final store = firestore.collection(usersCollection).doc(currentUser!.uid);

      // Fetch the existing data if imgUrl is null
      if (imgUrl == null) {
        final snapshot = await store.get();
        if (snapshot.exists) {
          imgUrl = snapshot.data()?['imageUrl'] ?? '';
        }
      }

      // Update the document with new or existing values
      await store.set({
        if (name != null) 'name': name,
        if (password != null) 'password': password,
        if (imgUrl != null) 'imageUrl': imgUrl,
      }, SetOptions(merge: true));

      isLoading(false);
      Fluttertoast.showToast(msg: "Profile updated successfully!");
    } catch (e) {
      print('Error updating profile: $e');
      Fluttertoast.showToast(msg: "Failed to update profile.");
    }
  }

}
