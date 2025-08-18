import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:influbee/app/routes.dart';
import 'package:influbee/view/WalletAndEarning/transactionsection.dart';

import '../../common/DailogBox.dart';
import '../../controller/wallet_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  final WalletController controller = Get.put(WalletController());

  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0C21),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),

        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Wallet & Earnings",
            style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
            color: Colors.white,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF7A3DF5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Earnings",
                      style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8),
                  Text("\$${controller.totalEarnings.value}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // _actionButton(Icons.add, "Add Funds", () {
                      //   controller.addFunds(10);
                      // }),
                      _actionButton(Icons.account_balance_wallet, "Withdraw", () {
                        CommonDialog.show(
                          title: "Coming Soon",
                          message: "Withdraw feature will be available shortly!",
                        );
                      }),
                      // _actionButton(Icons.send, "Send", () {
                      //   controller.send(3);
                      // }),
                    ],
                  )
                ],
              ),
            )),
            // const SizedBox(height: 20),
            // const Text("Earning Statistics",
            //     style: TextStyle(
            //         color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Recent Transactions",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    // Text("View All", style: TextStyle(color: Colors.purpleAccent)),
                  ],
                ),
                const SizedBox(height: 10),

                // Put TransactionSection below the row
                TransactionSection(),
              ],
            ),
            //
            // const SizedBox(height: 10),
            // Expanded(
            //   child: Obx(() => controller.transactions.isEmpty
            //       ? const Center(
            //       child: Text("No Transactions",
            //           style: TextStyle(color: Colors.white54)))
            //       : ListView.builder(
            //     itemCount: controller.transactions.length,
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(controller.transactions[index],
            //             style: const TextStyle(color: Colors.white)),
            //       );
            //     },
            //   )),
            // )
          ],
        ),
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12))
      ],
    );
  }
}
