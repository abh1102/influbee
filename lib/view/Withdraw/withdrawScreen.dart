import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/TransactionController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class Withdrawscreen extends StatefulWidget {
//   const Withdrawscreen({super.key});
//
//   @override
//   State<Withdrawscreen> createState() => _WithdrawscreenState();
// }
//
// class _WithdrawscreenState extends State<Withdrawscreen> {
//   final TransactionController controller = Get.put(TransactionController());
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Show popup notification after the screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Get.snackbar(
//         "Coming Soon 🚀",
//         "Withdraw feature will be available shortly.",
//         snackPosition: SnackPosition.TOP,
//         backgroundColor: Colors.purple.withOpacity(0.9),
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(12),
//         borderRadius: 12,
//         duration: const Duration(seconds: 3),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D102D),
//       appBar: AppBar(
//         title: const Text("Withdraw", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.purple,
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           ),
//           onPressed: () {
//             Get.to(() => const TransactionHistoryScreen());
//           },
//           child: const Text(
//             "Transaction History",
//             style: TextStyle(color: Colors.white, fontSize: 16),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TransactionHistoryScreen extends StatelessWidget {
//   const TransactionHistoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final TransactionController controller = Get.find();
//
//     final List<String> mainTabs = ["All Calls", "Scheduled", "History"];
//     final List<String> subTabs = ["Audio", "Video", "Exclusive", "Message"];
//
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D102D),
//       appBar: AppBar(
//         title: const Text("Transaction History", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Main Tabs
//             Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: mainTabs.map((tab) {
//                 bool isSelected = controller.selectedMainTab.value == tab;
//                 return GestureDetector(
//                   onTap: () => controller.changeMainTab(tab),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? Colors.purple : Colors.transparent,
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: Colors.purple),
//                     ),
//                     child: Text(
//                       "$tab ${controller.getMainTabCount(tab)}",
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             )),
//             const SizedBox(height: 10),
//
//             // Sub Tabs
//             // Sub Tabs
//             Obx(() {
//               if (controller.selectedMainTab.value == "All Calls") {
//                 final subTabIcons = {
//                   "Audio": Icons.mic,
//                   "Video": Icons.videocam,
//                   "Exclusive": Icons.star,
//                   "Message": Icons.message,
//                 };
//
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: subTabs.map((tab) {
//                     bool isSelected = controller.selectedSubTab.value == tab;
//                     return GestureDetector(
//                       onTap: () => controller.changeSubTab(tab),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                         decoration: BoxDecoration(
//                           color: isSelected ? Colors.purple : Colors.transparent,
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: Colors.purple),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               subTabIcons[tab],
//                               color: Colors.white,
//                               size: 18,
//                             ),
//                             const SizedBox(width: 6),
//                             Text(
//                               "${controller.getSubTabCount(tab)}",
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               } else {
//                 return const SizedBox.shrink();
//               }
//             }),
//
//             const SizedBox(height: 12),
//
//             // Transactions List
//             Expanded(
//               child: Obx(() {
//                 var data = controller.filteredTransactions;
//                 if (data.isEmpty) {
//                   return const Center(
//                     child: Text("No transactions found", style: TextStyle(color: Colors.white)),
//                   );
//                 }
//                 return ListView.builder(
//                   itemCount: data.length,
//                   itemBuilder: (context, index) {
//                     final tx = data[index];
//                     return Container(
//                       margin: const EdgeInsets.only(bottom: 8),
//                       padding: const EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(tx.userName,
//                                   style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
//                               Text(tx.type,
//                                   style: const TextStyle(color: Colors.white70, fontSize: 12)),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Text("₹ ${tx.amount}",
//                                   style: const TextStyle(color: Colors.greenAccent, fontSize: 14, fontWeight: FontWeight.bold)),
//                               Text(tx.date,
//                                   style: const TextStyle(color: Colors.white54, fontSize: 12)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
