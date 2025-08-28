import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../controller/Home_Controller.dart';

class HomeNewView extends GetView<HomeNewController> {
  const HomeNewView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ---------------- Header ----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: ()=>Get.toNamed(AppRoutes.SETTINGS),
                     child: CircleAvatar(
                        radius: 22,
                        backgroundImage: AssetImage("assets/user.jpg"),
                      )
                        ,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Welcome back,", style: TextStyle(color: Colors.white70, fontSize: 14)),
                          Obx(() => Text(
                            controller.userName.value,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          )),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: ()=>Get.toNamed(AppRoutes.NOTIFICATIONS),
                  child: Stack(
                    children: const [
                      
                      Icon(Icons.notifications, color: Colors.white, size: 28),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(radius: 6, backgroundColor: Colors.red),
                      )
                    ],
                  )
                  )
                ],
              ),

              const SizedBox(height: 24),

              // ---------------- Earnings Card ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Earnings", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 8),
                    Obx(() => Text("\$${controller.totalEarnings}",
                        style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 4),
                    Obx(() => Text(controller.earningsGrowth.value,
                        style: const TextStyle(color: Colors.greenAccent, fontSize: 12))),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- URL Copy Section ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Obx(() => Text(
                        controller.userUrl.value,
                        style: const TextStyle(color: Colors.white70),
                        overflow: TextOverflow.ellipsis,
                      )),
                    ),
                    const Icon(Icons.copy, color: Colors.orangeAccent),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // ---------------- Main KPIs ----------------
              const Text("Main KPIs", style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),

              Obx(() => GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: size.width > 600 ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _kpiCard("Earnings", controller.kpiEarnings.value, controller.kpiEarningsChange.value, Colors.green),
                  _kpiCard("Fans", controller.kpiFans.value, controller.kpiFansChange.value, Colors.green),
                  _kpiCard("Engagement", controller.kpiEngagement.value, controller.kpiEngagementChange.value, Colors.red),
                ],
              )),

              const SizedBox(height: 20),

              // ---------------- Quick Actions ----------------
              const Text("Quick Actions", style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _quickAction("Upload", Icons.upload, Colors.orange, onTap:()=>Get.toNamed(AppRoutes.NEWPOST),
                  
                  ),
                  _quickAction(
                    "Booking",
                    Icons.calendar_month,
                    Colors.deepPurple,
                    onTap: () => controller.onBooking(context),
                  ),                  _quickAction("Setup", Icons.person, Colors.teal, onTap: controller.onProfile),
                ],
              ),

              const SizedBox(height: 20),

              // ---------------- Earnings Analytics ----------------
              const Text("Earnings Analytics", style: TextStyle(color: Colors.white, fontSize: 16)),
              const SizedBox(height: 12),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text("Analytics Chart Placeholder", style: TextStyle(color: Colors.white54)),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  // KPI Card Widget
  static Widget _kpiCard(String title, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(change, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  // Quick Action Widget
  static Widget _quickAction(String label, IconData icon, Color color, {VoidCallback? onTap}) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
