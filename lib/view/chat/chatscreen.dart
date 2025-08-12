import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/chat_contoller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "1 conversations",
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),

            // Search Field
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (val) => controller.searchQuery.value = val,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search conversations...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tabs
            Obx(() => Row(
              children: [
                _tabButton("All", 0, controller),
                const SizedBox(width: 12),
                _tabButton("Unread", 1, controller),
              ],
            )),

            const SizedBox(height: 16),

            // Chat Card
            _chatCard(),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title, int index, ChatController controller) {
    final isSelected = controller.tabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.tabIndex.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.deepPurple : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chatCard() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.deepPurple,
                child: Text('C', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("Chat User", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Welcome to Influbee! How can we ...", style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text("3:05:28 pm", style: TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
