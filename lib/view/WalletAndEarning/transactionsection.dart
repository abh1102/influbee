import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/TransactionController.dart';

class TransactionSection extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  TransactionSection({super.key});

  final List<String> mainTabs = ["All Calls", "Scheduled", "History"];
  final List<String> subTabs = ["Audio", "Video", "Exclusive", "Message"];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Main Tabs
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: mainTabs.map((tab) {
            bool isSelected = controller.selectedMainTab.value == tab;
            return GestureDetector(
              onTap: () => controller.changeMainTab(tab),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.purple : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.purple),
                ),
                child: Text(
                  "$tab ${controller.getMainTabCount(tab)}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }).toList(),
        )),
        const SizedBox(height: 10),

        // 🔹 Sub Tabs
        Obx(() {
          if (controller.selectedMainTab.value == "All Calls") {
            final subTabIcons = {
              "Audio": Icons.mic,
              "Video": Icons.videocam,
              "Exclusive": Icons.star,
              "Message": Icons.message,
            };

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: subTabs.map((tab) {
                bool isSelected = controller.selectedSubTab.value == tab;
                return GestureDetector(
                  onTap: () => controller.changeSubTab(tab),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.purple : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.purple),
                    ),
                    child: Row(
                      children: [
                        Icon(subTabIcons[tab],
                            color: Colors.white, size: 18),
                        const SizedBox(width: 6),
                        Text("${controller.getSubTabCount(tab)}",
                            style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),

        const SizedBox(height: 16),

        // 🔹 Transactions List (auto-fit instead of Expanded)
        Obx(() {
          final txList = controller.filteredTransactions;
          if (txList.isEmpty) {
            return const Center(
              child: Text("No transactions found",
                  style: TextStyle(color: Colors.white)),
            );
          }
          return ListView.builder(
            shrinkWrap: true, // important!
            physics: const NeverScrollableScrollPhysics(), // let parent scroll
            itemCount: txList.length,
            itemBuilder: (context, index) {
              final tx = txList[index];
              return Card(
                color: Colors.grey[900],
                margin:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(tx.userName,
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text("${tx.type} • ${tx.date}",
                      style: const TextStyle(color: Colors.grey)),
                  trailing: Text(
                    "₹${tx.amount}",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
