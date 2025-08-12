import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/VoiceController.dart';

class VoiceCallsView extends GetView<VoiceCallsController> {
  const VoiceCallsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          'Voice Calls',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert, color: Colors.white),
          )
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(24),
          child: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Manage your voice connections',
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _SummaryCard(title: '\$0', subtitle: 'Call Earnings'),
                _SummaryCard(title: '0', subtitle: 'Completed'),
                _SummaryCard(title: '0', subtitle: 'Scheduled'),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quick Actions',
                      style: TextStyle(color: Colors.white, fontSize: 14)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _ActionButton(
                          icon: Icons.videocam, label: 'Start Video Call', color: Color(0xFF8E2DE2)),
                      _ActionButton(
                          icon: Icons.call, label: 'Start Voice Call', color: Color(0xFF009688)),
                      _ActionButton(
                          icon: Icons.schedule, label: 'Schedule Call', color: Color(0xFFFF9800)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tab Buttons
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) {
                  final labels = ['All Calls', 'Scheduled', 'History'];
                  final isSelected = controller.selectedTabIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.selectedTabIndex.value = index,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.deepPurple : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.deepPurple),
                      ),
                      child: Row(
                        children: [
                          Text(
                            labels[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            '0',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            }),
            const SizedBox(height: 40),

            // Empty State
            Center(
              child: Column(
                children: const [
                  Icon(Icons.phone_disabled, color: Colors.white24, size: 64),
                  SizedBox(height: 12),
                  Text("No all calls",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 4),
                  Text("Your call history will appear here",
                      style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SummaryCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionButton({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 10)),
      ],
    );
  }
}
