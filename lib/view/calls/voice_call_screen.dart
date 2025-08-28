import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/VoiceController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VoiceCallsView extends GetView<VoiceCallsController> {
  const VoiceCallsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Calls",
          style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // actions: [
        //   Row(
        //     children: [
        //       const Text("Notifications", style: TextStyle(color: Colors.white70, fontSize: 12)),
        //       const SizedBox(width: 6),
        //       Switch(
        //         value: true,
        //         onChanged: (_) {},
        //         activeColor: Colors.orange,
        //       ),
        //     ],
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _StatCard(value: "12", label: "Total Calls"),
                _StatCard(value: "245", label: "Minutes"),
                _StatCard(value: "₹80.00", label: "Earnings"),
              ],
            ),
            const SizedBox(height: 20),

            // Filter Tabs (All / Missed Calls)
            Obx(() {
              return Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      text: "All",
                      selected: controller.selectedTabIndex.value == 0,
                      onTap: () => controller.selectedTabIndex.value = 0,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _TabButton(
                      text: "Missed Calls",
                      selected: controller.selectedTabIndex.value == 1,
                      onTap: () => controller.selectedTabIndex.value = 1,
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 12),

            // Audio / Video Filter Buttons
          // Inside VoiceCallsView build()
            Obx(() => Row(
              children: [
                Expanded(
                  child: _FilterButton(
                    icon: Icons.call,
                    label: "Audio",
                    selected: controller.selectedFilter.value == "audio",
                    onTap: () => controller.selectedFilter.value = "audio",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _FilterButton(
                    icon: Icons.videocam,
                    label: "Video",
                    selected: controller.selectedFilter.value == "video",
                    onTap: () => controller.selectedFilter.value = "video",
                  ),
                ),
              ],
            )),


            const SizedBox(height: 24),

            // Calls List
            _SectionTitle("TODAY"),
            const _CallTile(
              name: "Abhi",
              type: "Video Call",
              status: "Completed - 15:30",
              amount: "₹30.00",
              rating: 4.5,
              isMissed: false,
              avatar: "https://i.pravatar.cc/100?img=1",
            ),
            const _CallTile(
              name: "Pragya",
              type: "Audio Call",
              status: "Missed",
              amount: "₹30.00",
              rating: 0,
              isMissed: true,
              avatar: "https://i.pravatar.cc/100?img=2",
            ),
            const SizedBox(height: 16),

            _SectionTitle("YESTERDAY"),
            const _CallTile(
              name: "AJ",
              type: "Video Call",
              status: "Completed - 20:00",
              amount: "₹30.00",
              rating: 5,
              isMissed: false,
              avatar: "https://i.pravatar.cc/100?img=3",
            ),
            const SizedBox(height: 16),

            _SectionTitle("OLDER"),
            const _CallTile(
              name: "John",
              type: "Audio Call",
              status: "Scheduled: Tomorrow",
              amount: "₹30.00",
              rating: 0,
              isMissed: false,
              avatar: "https://i.pravatar.cc/100?img=4",
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(value, style: const TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton({required this.text, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? Colors.white : Colors.orange, size: 18),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallTile extends StatelessWidget {
  final String name;
  final String type;
  final String status;
  final String amount;
  final double rating;
  final bool isMissed;
  final String avatar;

  const _CallTile({
    required this.name,
    required this.type,
    required this.status,
    required this.amount,
    required this.rating,
    required this.isMissed,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(avatar), radius: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$type with $name",
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(
                  status,
                  style: TextStyle(
                    color: isMissed ? Colors.redAccent : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(color: Colors.yellow, fontSize: 14, fontWeight: FontWeight.bold)),
              if (rating > 0)
                Row(
                  children: List.generate(
                    5,
                        (i) => Icon(
                      i < rating.floor() ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 14,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(text,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}

