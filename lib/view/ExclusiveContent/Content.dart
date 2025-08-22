import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/contetn_controller.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentScreen extends StatelessWidget {
  final ContentController controller = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Content",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTabSwitcher(),
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              final items = controller.filteredContents;
              if (items.isEmpty) {
                return Center(
                  child: Text("No content found",
                      style: TextStyle(color: Colors.white)),
                );
              }
              return GridView.builder(
                padding: EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(item.file, fit: BoxFit.cover),
                        if (item.type == ContentType.video)
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Icon(Icons.play_circle,
                                color: Colors.white, size: 28),
                          )
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
        onPressed: () {
          _showPicker(context);
        },
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Obx(() {
      return Row(
        children: [
          _tabButton("Images", ContentType.image),
          _tabButton("Videos", ContentType.video),
        ],
      );
    });
  }

  Widget _tabButton(String label, ContentType type) {
    final isSelected = controller.selectedTab.value == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setTab(type),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.amber : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: controller.setSearch,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search content...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[850],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 8),
          _circleIcon(Icons.filter_list),
          SizedBox(width: 8),
          _circleIcon(Icons.sort),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  void _showPicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Upload Image"),
              onTap: () {
                controller.pickImage();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text("Upload Video"),
              onTap: () {
                controller.pickVideo();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
