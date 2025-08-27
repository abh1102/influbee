import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influbee/view/NewPost/widgets/BottomBar.dart';
import 'package:influbee/view/NewPost/widgets/Detail.dart';
import 'package:influbee/view/NewPost/widgets/MediaStep.dart';
import 'package:influbee/view/NewPost/widgets/Price.dart';
import 'package:influbee/view/NewPost/widgets/ReviewStep.dart';
import 'package:influbee/view/NewPost/widgets/StepHeader.dart';

import '../../controller/NewPostController.dart';

class NewPostView extends GetView<NewPostController> {
  const NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NewPostController());
    const bg = Color(0xFF0B0F1A);
    const card = Color(0xFF12162A);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: Obx(() {
          // 🔥 Show back arrow only on last step
          if (controller.isLast) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => controller.previousOrCancel(),
            );
          }
          return IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => controller.previousOrCancel(),
          );
        }),
        centerTitle: true,
        title: const Text(
          'New Post',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              StepHeader(controller: controller),
              const SizedBox(height: 8),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: SingleChildScrollView(
                    key: ValueKey(controller.currentStep.value),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                    child: _buildStepContent(controller, card),
                  ),
                ),
              ),
            ],
          );
        }),
      ),

      /// 🔥 Only build BottomBar if not last
      bottomNavigationBar: Obx(() {
        final isLast = controller.isLast; // <-- this reads the Rx
        if (isLast) return const SizedBox.shrink();
        return BottomBar(controller: controller);
      }),    );
}

  Widget _buildStepContent(NewPostController c, Color card) {
    switch (c.currentStep.value) {
      case 0:
        return MediaStep(card: card, controller: c, key: const ValueKey('media'));
      case 1:
        return DetailsStep(card: card, controller: c, key: const ValueKey('details'));
      case 2:
        return PriceStep(card: card, controller: c, key: const ValueKey('price'));
      case 3:
      default:
        return ReviewStep(card: card, controller: c, key: const ValueKey('review'));
    }
  }
}

// class _StepHeader extends StatelessWidget {
//   const _StepHeader({required this.controller});
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     const barHeight = 4.0;
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Labels row (clickable)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(NewPostController.steps.length, (i) {
//               final isActive = controller.currentStep.value == i;
//               return GestureDetector(
//                 behavior: HitTestBehavior.opaque,
//                 onTap: () => controller.goTo(i),
//                 child: Text(
//                   NewPostController.steps[i],
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
//                     color: isActive ? Colors.white : Colors.white70,
//                   ),
//                 ),
//               );
//             }),
//           ),
//           const SizedBox(height: 8),
//
//           // Progress bar (full width grey + animated orange foreground)
//           LayoutBuilder(
//             builder: (context, cts) {
//               final full = cts.maxWidth;
//               final active = full * controller.progress;
//               return Stack(
//                 children: [
//                   Container(
//                     height: barHeight,
//                     width: full,
//                     decoration: BoxDecoration(
//                       color: Colors.white12,
//                       borderRadius: BorderRadius.circular(999),
//                     ),
//                   ),
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 250),
//                     height: barHeight,
//                     width: active,
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFFFA21A),
//                       borderRadius: BorderRadius.circular(999),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _MediaStep extends StatelessWidget {
//   const _MediaStep({super.key, required this.card, required this.controller});
//   final Color card;
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _SectionCard(
//             color: card,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const _SectionTitle('Upload Media'),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Supported formats: JPG, PNG, MP4. Max size: 50MB.',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//                 const SizedBox(height: 16),
//
//                 GestureDetector(
//                   onTap: _pickFile,
//                   child: DottedBorder(
//                     color: const Color(0xFFFFA21A),
//                     dashPattern: const [7, 6],
//                     strokeWidth: 1.6,
//                     borderType: BorderType.RRect,
//                     radius: const Radius.circular(14),
//                     child: Container(
//                       width: double.infinity,
//                       height: 180,
//                       alignment: Alignment.center,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(Icons.insert_drive_file, size: 40, color: Color(0xFFFFA21A)),
//                           const SizedBox(height: 10),
//                           const Text('Drag & drop files here',
//                               style: TextStyle(color: Colors.white70)),
//                           const SizedBox(height: 2),
//                           const Text('or', style: TextStyle(color: Colors.white54)),
//                           const SizedBox(height: 10),
//                           ElevatedButton(
//                             onPressed: _pickFile,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFFFFA21A),
//                               foregroundColor: Colors.black,
//                               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: const Text('Browse Files'),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 14),
//           const _SectionTitle('Preview'),
//           const SizedBox(height: 8),
//
//           Obx(() {
//             final file = controller.selectedFile.value;
//             return ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Container(
//                 decoration: BoxDecoration(color: card, borderRadius: BorderRadius.circular(14)),
//                 height: 170,
//                 width: double.infinity,
//                 child: file == null
//                     ? const Center(
//                   child: Text('No file selected', style: TextStyle(color: Colors.white54)),
//                 )
//                     : _Preview(file: file),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _pickFile() async {
//     final res = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'jpeg', 'png', 'mp4'],
//     );
//     if (res != null && res.files.single.path != null) {
//       controller.setFile(File(res.files.single.path!));
//     }
//   }
// }

// class _DetailsStep extends StatelessWidget {
//   const _DetailsStep({super.key, required this.card, required this.controller});
//   final Color card;
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     final titleCtrl = TextEditingController(text: controller.title.value);
//     final descCtrl = TextEditingController(text: controller.description.value);
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: _SectionCard(
//         color: card,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const _SectionTitle('Details'),
//             const SizedBox(height: 16),
//             _LabeledField(
//               label: 'Title',
//               child: TextField(
//                 controller: titleCtrl,
//                 onChanged: (v) => controller.title.value = v,
//                 decoration: _inputDecoration('Enter title'),
//               ),
//             ),
//             const SizedBox(height: 12),
//             _LabeledField(
//               label: 'Description',
//               child: TextField(
//                 controller: descCtrl,
//                 onChanged: (v) => controller.description.value = v,
//                 maxLines: 5,
//                 decoration: _inputDecoration('Write something about your post'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _PriceStep extends StatelessWidget {
//   const _PriceStep({super.key, required this.card, required this.controller});
//   final Color card;
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     final priceCtrl = TextEditingController(text: controller.price.value);
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: _SectionCard(
//         color: card,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const _SectionTitle('Price'),
//             const SizedBox(height: 16),
//             _LabeledField(
//               label: 'Amount',
//               child: TextField(
//                 controller: priceCtrl,
//                 keyboardType: TextInputType.number,
//                 onChanged: (v) => controller.price.value = v,
//                 decoration: _inputDecoration('e.g. 499'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ReviewStep extends StatelessWidget {
//   const _ReviewStep({super.key, required this.card, required this.controller});
//   final Color card;
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: _SectionCard(
//         color: card,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const _SectionTitle('Review'),
//             const SizedBox(height: 12),
//             _ReviewRow('Title', controller.title.value.isEmpty ? '—' : controller.title.value),
//             _ReviewRow('Description',
//                 controller.description.value.isEmpty ? '—' : controller.description.value),
//             _ReviewRow('Price', controller.price.value.isEmpty ? '—' : '₹ ${controller.price.value}'),
//             const SizedBox(height: 12),
//             const Divider(color: Colors.white12),
//             const SizedBox(height: 8),
//             const Text('Preview', style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(height: 8),
//             Obx(() {
//               final f = controller.selectedFile.value;
//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   height: 150,
//                   width: double.infinity,
//                   color: const Color(0xFF12162A),
//                   child: f == null ? const Center(child: Text('No media')) : _Preview(file: f),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _BottomBar extends StatelessWidget {
//   const _BottomBar({required this.controller});
//   final NewPostController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     final isFirst = controller.currentStep.value == 0;
//
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
//       decoration: const BoxDecoration(color: Colors.transparent),
//       child: Row(
//         children: [
//           Expanded(
//             child: OutlinedButton(
//               onPressed: () => controller.previousOrCancel(),
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Colors.white24),
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 backgroundColor: const Color(0xFF0B0F1A),
//               ),
//               child: Text(isFirst ? 'Cancel' : 'Back',
//                   style: const TextStyle(color: Colors.white)),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => controller.nextStep(),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFFFA21A),
//                 foregroundColor: Colors.black,
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//               ),
//               child: Text(controller.isLast ? 'Submit' : 'Next'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// ---------- Reusable widgets ----------

// class _SectionCard extends StatelessWidget {
//   const _SectionCard({required this.color, required this.child});
//   final Color color;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: child,
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   const _SectionTitle(this.text);
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Text(text,
//         style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700));
//   }
// }

// class _LabeledField extends StatelessWidget {
//   const _LabeledField({required this.label, required this.child});
//   final String label;
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
//       const SizedBox(height: 6),
//       child,
//     ]);
//   }
// }

InputDecoration _inputDecoration(String hint) => InputDecoration(
  hintText: hint,
  filled: true,
  fillColor: const Color(0xFF0B0F1A),
  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white12),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white12),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Color(0xFFFFA21A), width: 1.2),
  ),
);

// class _Preview extends StatelessWidget {
//   const _Preview({required this.file});
//   final File file;
//
//   bool get isVideo => file.path.toLowerCase().endsWith('.mp4');
//
//   @override
//   Widget build(BuildContext context) {
//     if (isVideo) {
//       return const Center(child: Icon(Icons.play_circle_outline, size: 48));
//     }
//     return Image.file(file, fit: BoxFit.cover);
//   }
// }

// class _ReviewRow extends StatelessWidget {
//   const _ReviewRow(this.label, this.value);
//   final String label;
//   final String value;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 90,
//             child: Text(label, style: const TextStyle(color: Colors.white70)),
//           ),
//           const SizedBox(width: 8),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }
// }
