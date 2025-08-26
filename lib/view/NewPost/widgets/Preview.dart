import 'dart:io';

import 'package:flutter/material.dart';
class Preview extends StatelessWidget {
  const Preview({required this.file});
  final File file;

  bool get isVideo => file.path.toLowerCase().endsWith('.mp4');

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
      return const Center(child: Icon(Icons.play_circle_outline, size: 48));
    }
    return Image.file(file, fit: BoxFit.cover);
  }
}
