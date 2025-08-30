import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  Rx<File?> selectedImage = Rx<File?>(null);
  RxString selectedImageType = ''.obs;

  Future<void> selectImage(String type) async {
    XFile? image;
    if (type == 'gallery') {
      image = await _picker.pickImage(source: ImageSource.gallery);
    } else if (type == 'camera') {
      image = await _picker.pickImage(source: ImageSource.camera);
    }

    if (image != null) {
      selectedImage.value = File(image.path);
      selectedImageType.value = type;
      Get.snackbar(
        "Success",
        "${type.toUpperCase()} selected successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF4CAF50),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  void removeImage() {
    selectedImage.value = null;
    selectedImageType.value = '';
    Get.snackbar(
      "Removed",
      "Profile picture removed",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF616161),
      colorText: const Color(0xFFFFFFFF),
    );
  }

  void saveProfilePicture() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF4CAF50),
              size: 64,
            ),
            const SizedBox(height: 16),
            const Text(
              'Profile Picture Updated!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your profile picture has been successfully updated.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // close dialog
                  Get.back(); // close page
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9500),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

