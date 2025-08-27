import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class Preview extends StatefulWidget {
  const Preview({required this.file, super.key});
  final File file;

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  VideoPlayerController? _controller;

  bool get isVideo => widget.file.path.toLowerCase().endsWith('.mp4');

  @override
  void initState() {
    super.initState();
    if (isVideo) {
      _controller = VideoPlayerController.file(widget.file)
        ..initialize().then((_) {
          setState(() {}); // refresh once initialized
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isVideo) {
      if (_controller == null || !_controller!.value.isInitialized) {
        return const Center(child: CircularProgressIndicator());
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
          IconButton(
            icon: Icon(
              _controller!.value.isPlaying ? Icons.pause_circle : Icons.play_circle,
              size: 48,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _controller!.value.isPlaying
                    ? _controller!.pause()
                    : _controller!.play();
              });
            },
          ),
        ],
      );
    }

    // Default: show image
    return Image.file(widget.file, fit: BoxFit.cover);
  }
}
