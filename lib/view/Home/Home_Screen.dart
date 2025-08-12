import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/Home_Controller.dart';
import '../Drawer/DrawerScreen.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),        title: Obx(() => Text.rich(
          TextSpan(
            text: '${controller.greeting.value},\n',
            children: const [
              TextSpan(
                text: 'Test User!',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        )),
        actions: const [
          Stack(
            children: [
              Icon(Icons.notifications, color: Colors.white),
              Positioned(
                top: 0,
                right: 0,
                child: CircleAvatar(radius: 6, backgroundColor: Colors.red),
              ),
            ],
          ),
          SizedBox(width: 16),
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.deepPurple,
            child: Text('T', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top 4 Cards
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _dashboardCard("Earnings", "\$${controller.earnings}", Icons.attach_money, Colors.green),
                _dashboardCard("New Fans", "+${controller.newFans}", Icons.people, Colors.orange),
                _dashboardCard("Bookings", "${controller.bookings} Up", Icons.calendar_today, Colors.red),
                _dashboardCard("Messages", "${controller.messages} New", Icons.message, Colors.blue),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Quick Actions", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            Row(
              children: [
                _actionButton("New Post", Icons.add, const Color(0xFFF8A600)),
                const SizedBox(width: 16),
                _actionButton("Schedule", Icons.calendar_today, const Color(0xFFBA68C8)),
              ],
            ),
            const SizedBox(height: 32),
            const Text("For You", style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 12),
            _forYouCard("Boost Your Latest Content!", "Your recent voice messages are performing well.", Icons.trending_up),
            _forYouCard("New Fan Interaction", "Test User, you have new fans interacting with your profile!", Icons.favorite),
            _forYouCard("Complete Your Profile", "Add more details to your profile", Icons.phone_android),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, String value, IconData icon, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(color: valueColor, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.9), color]),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forYouCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        trailing: const Text(
          "Now",
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }
}
