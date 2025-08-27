import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/NewPostController.dart';
import 'Preview.dart';
import 'SectionCard.dart';
import 'SectionTitle.dart';
class MediaStep extends StatelessWidget {
  const MediaStep({super.key, required this.card, required this.controller});
  final Color card;
  final NewPostController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionCard(
            color: card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SectionTitle('Upload Media'),
                const SizedBox(height: 4),
                const Text(
                  'Supported formats: JPG, PNG, MP4. Max size: 50MB.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: _pickFile,
                  child: DottedBorder(
                    color: const Color(0xFFFFA21A),
                    dashPattern: const [7, 6],
                    strokeWidth: 1.6,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(14),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.insert_drive_file, size: 40, color: Color(0xFFFFA21A)),
                          const SizedBox(height: 10),
                          // const Text('Drag & drop files here',
                          //     style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 2),
                          // const Text('or', style: TextStyle(color: Colors.white54)),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: _pickFile,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFA21A),
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Browse Files'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
          const SectionTitle('Preview'),
          const SizedBox(height: 8),

          Obx(() {
            final file = controller.selectedFile.value;
            return ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(14)),
                height: 170,
                width: double.infinity,
                child: file == null
                    ? const Center(
                  child: Text('No file selected', style: TextStyle(color: Colors.white54)),
                )
                    : Preview(file: file),
              ),
            );
          }),
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
    );
    if (res != null && res.files.single.path != null) {
      controller.setFile(File(res.files.single.path!));
    }
  }
}
