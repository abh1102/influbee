import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
                route: '/',
                context: context,
              ),
              _buildNavItem(
                icon: Icons.message,
                label: 'Message',
                index: 1,
                route: '/messages',
                context: context,
              ),
              _buildNavItem(
                icon: Icons.call,
                label: 'Call',
                index: 2,
                route: '/calls',
                context: context,
              ),
              _buildNavItem(
                icon: Icons.account_balance_wallet,
                label: 'Wallet',
                index: 3,
                route: '/wallet',
                context: context,
              ),
              _buildNavItem(
                icon: Icons.star,
                label: 'Exclusive',
                index: 4,
                route: '/content_library',
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required String route,
    required BuildContext context,
  }) {
    bool isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        onTap(index);
        if (!isSelected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9500).withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFF9500) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFF9500) : Colors.grey,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
