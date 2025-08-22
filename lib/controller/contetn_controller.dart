import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum ContentType { image, video }

class ContentItem {
  final File file;
  final ContentType type;

  ContentItem({required this.file, required this.type});
}

class ContentController extends GetxController {
  final picker = ImagePicker();

  var contents = <ContentItem>[].obs;
  var selectedTab = ContentType.image.obs;
  var searchText = ''.obs;

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      contents.add(ContentItem(file: File(picked.path), type: ContentType.image));
    }
  }

  Future<void> pickVideo() async {
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) {
      contents.add(ContentItem(file: File(picked.path), type: ContentType.video));
    }
  }

  void setTab(ContentType type) {
    selectedTab.value = type;
  }

  void setSearch(String text) {
    searchText.value = text.toLowerCase();
  }

  List<ContentItem> get filteredContents {
    return contents.where((item) {
      final matchesTab = item.type == selectedTab.value;
      final matchesSearch = item.file.path.toLowerCase().contains(searchText.value);
      return matchesTab && matchesSearch;
    }).toList();
  }
}
