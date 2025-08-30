import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:influbee/view/Payout/pan_details_page.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';

import '../../controller/PayoutController.dart';
import 'pan_details_page.dart';

class PayoutSetupPage extends StatefulWidget {
  PayoutSetupPage({super.key});

  @override
  State<PayoutSetupPage> createState() => _PayoutSetupPageState();
}

class _PayoutSetupPageState extends State<PayoutSetupPage> {
  final controller = Get.put(PayoutController());

  final _aadharController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFile(bool isFront) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (isFront) {
          controller.setAadharFront(file);
        } else {
          controller.setAadharBack(file);
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    _aadharController.text = controller.aadharNumber.value;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text('Payout Setup',
            style: TextStyle(color: Colors.white, fontSize: 18)),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildProgressBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Step 1: Aadhar Details',
                      style: TextStyle(
                          color: Color(0xFFFF9500),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),

                  // Aadhar Number
                  const Text('Aadhar Number',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _aadharController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'XXXX XXXX XXXX',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: controller.setAadhar,
                  ),

                  const SizedBox(height: 32),

                  // Upload Front + Back
                  Obx(() => Row(
                    children: [
                      Expanded(
                        child: _buildUploadSection(
                          'Upload Front',
                          controller.aadharFront!.value != null,   // ✅ use .value
                              () => _pickFile(true),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildUploadSection(
                          'Upload Back',
                          controller.aadharBack!.value != null,    // ✅ use .value
                              () => _pickFile(false),
                        ),
                      ),
                    ],
                  )),

                ],
              ),
            ),
          ),

          // Next Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                if (controller.aadharNumber.value.isEmpty ||
                    controller.aadharFront.value == null ||
                    controller.aadharBack.value == null) {
                  Get.snackbar("Error", "Please complete Aadhar details",
                      backgroundColor: Colors.red, colorText: Colors.white);
                  return;
                }
                controller.currentStep.value = 2;
                Get.to(() => PanDetailsPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9500),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Obx(() => Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildStepIndicator(1, "Aadhar",
              controller.currentStep.value >= 1, const Color(0xFFFF9500)),
          _buildStepConnector(),
          _buildStepIndicator(2, "PAN",
              controller.currentStep.value >= 2, Colors.grey),
          _buildStepConnector(),
          _buildStepIndicator(3, "Bank", false, Colors.grey),
        ],
      ),
    ));
  }

  Widget _buildStepIndicator(
      int step, String label, bool isActive, Color color) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent,
            border: Border.all(color: color, width: 2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text("$step",
                style: TextStyle(
                    color: isActive ? Colors.white : color,
                    fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(
                color: color, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStepConnector() {
    return Expanded(
        child: Container(height: 2, margin: const EdgeInsets.only(bottom: 20),
            color: Colors.grey));
  }

  Widget _buildUploadSection(
      String title, bool isUploaded, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isUploaded
                  ? const Color(0xFFFF9500)
                  : Colors.grey.withOpacity(0.3),
              width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
                isUploaded ? Icons.check_circle : Icons.cloud_upload_outlined,
                color: isUploaded ? const Color(0xFFFF9500) : Colors.grey,
                size: 32),
            const SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    color: isUploaded ? const Color(0xFFFF9500) : Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
