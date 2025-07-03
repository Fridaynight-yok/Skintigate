import 'dart:io';

import 'package:dio/dio.dart' as dioTest;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadImg {
  final ImagePicker imagePicker = ImagePicker();
  final sendApi = GetConnect(); //ทำให้sendApi มีความสามารถของ Get

  Future<String> pickImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return "no image has picked";
    }
  }

  Future<String> uploadImage(String imagePath) async {
    final File? imageFile = File(imagePath);
    if (imageFile == null) {
      return 'no image found';
    }

    var data = dioTest.FormData.fromMap({
      'file': [
        await dioTest.MultipartFile.fromFile(
          imagePath,
          filename: imagePath.split('/').last,
        ),
      ],
      'upload_preset': 'Skintigate',
    });

    var dio = dioTest.Dio();
    var response = await dio.request(
      'https://api.cloudinary.com/v1_1/dtflazdw8/image/upload',
      options: dioTest.Options(method: 'POST'),
      data: data,
    );

    return response.data["secure_url"] ?? "error";
  }
}
