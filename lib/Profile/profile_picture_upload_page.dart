import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/selectimagecontroller.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePictureUploadPage extends StatelessWidget {
  final UploadController controller = Get.put(UploadController());

  ProfilePictureUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Profile Picture',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Current Profile Picture
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    final hasImage = controller.selectedImage.value != null;
                    return Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: hasImage
                            ? const Color(0xFF8B5CF6)
                            : const Color(0xFF2A2A2A),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 3,
                        ),
                      ),
                      child: hasImage
                          ? ClipOval(
                        child: Image.file(
                          File(controller.selectedImage.value!.path),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                        size: 60,
                      ),
                    );
                  }),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () => _showImageOptions(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9500),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Add Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose a photo that represents you. This will be visible to other users.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),

            // Upload Options
            _buildUploadOption(Icons.photo_library, 'Choose from Gallery',
                'Select from your existing photos',
                    () => controller.selectImage('gallery')),
            const SizedBox(height: 16),
            _buildUploadOption(Icons.camera_alt, 'Take Photo',
                'Capture a new photo with your camera',
                    () => controller.selectImage('camera')),
            const SizedBox(height: 16),
            _buildUploadOption(Icons.person, 'Choose Avatar',
                'Select from pre-designed avatars',
                    () => controller.selectImage('avatar')),

            Obx(() {
              if (controller.selectedImage.value == null) return Container();
              return Column(
                children: [
                  const SizedBox(height: 48),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Image Options',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildImageOption('Crop & Resize', Icons.crop),
                        const SizedBox(height: 12),
                        _buildImageOption('Apply Filter', Icons.filter),
                        const SizedBox(height: 12),
                        _buildImageOption(
                            'Adjust Brightness', Icons.brightness_6),
                      ],
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 48),

            // Action Buttons
            Obx(() {
              final hasImage = controller.selectedImage.value != null;
              return Row(
                children: [
                  if (hasImage) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: controller.removeImage,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Remove',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: ElevatedButton(
                      onPressed:
                      hasImage ? controller.saveProfilePicture : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasImage
                            ? const Color(0xFFFF9500)
                            : const Color(0xFF3A3A3A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        hasImage ? 'Save Picture' : 'Select Image First',
                        style: TextStyle(
                          color: hasImage ? Colors.white : Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadOption(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFFF9500), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Get.snackbar(
          "Coming Soon",
          "$title feature coming soon!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFF9500),
          colorText: Colors.white,
        );
      },
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF9500), size: 20),
          const SizedBox(width: 12),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            const Text(
              'Profile Picture Options',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionItem(Icons.photo_library, 'Choose from Gallery',
                    () => controller.selectImage('gallery')),
            _buildOptionItem(Icons.camera_alt, 'Take Photo',
                    () => controller.selectImage('camera')),
            _buildOptionItem(Icons.person, 'Choose Avatar',
                    () => controller.selectImage('avatar')),
            Obx(() {
              if (controller.selectedImage.value == null) return Container();
              return _buildOptionItem(Icons.delete, 'Remove Picture',
                  controller.removeImage,
                  isDestructive: true);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap,
      {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon,
          color: isDestructive ? Colors.red : Colors.white),
      title: Text(title,
          style:
          TextStyle(color: isDestructive ? Colors.red : Colors.white)),
      onTap: onTap,
    );
  }
}
