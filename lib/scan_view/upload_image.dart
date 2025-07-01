import 'dart:io';

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
    final cloudUrl =
        "https://api.cloudinary.com/v1_1/dtflazdw8/image/upload"; //find link on google, search "cloudinary uplaod url" -> guide ->basic upload
    final imageData = MultipartFile(
      imageFile,
      filename: imagePath.split("/").last,
    );
    Response res = await sendApi.post(
      cloudUrl,
      FormData({"upload_preset": "Skintigate", "file": imageData}),
    );

    return res.body["secure_url"] ?? "error";
  }
}
