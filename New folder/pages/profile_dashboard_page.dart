import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:flutter/services.dart';

class ProfileDashboardPage extends StatefulWidget {
  const ProfileDashboardPage({super.key});

  @override
  State<ProfileDashboardPage> createState() => _ProfileDashboardPageState();
}

class _ProfileDashboardPageState extends State<ProfileDashboardPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(),
              
              const SizedBox(height: 24),
              
              // Total Earnings
              _buildEarningsCard(),
              
              const SizedBox(height: 24),
              
              // URL Section
              _buildUrlSection(),
              
              const SizedBox(height: 24),
              
              // Performance Section
              _buildPerformanceSection(),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              _buildQuickActions(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile_settings');
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF8B5CF6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'HB',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                'Honey Bee',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/notifications');
          },
        ),
        IconButton(
          icon: const Icon(Icons.apps, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/all_pages');
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Earnings',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '\$7,500',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Color(0xFF10B981),
                size: 16,
              ),
              const SizedBox(width: 4),
              const Text(
                '+10%',
                style: TextStyle(
                  color: Color(0xFF10B981),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'vs last month',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUrlSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'URL',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.link,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'influbee.io/honeybee',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: 'influbee.io/honeybee'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('URL copied to clipboard'),
                      backgroundColor: Color(0xFFFF9500),
                    ),
                  );
                },
                child: const Icon(
                  Icons.copy,
                  color: Color(0xFFFF9500),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Performance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildPerformanceItem('Earnings', '\$264', '+5%', const Color(0xFF10B981))),
              Expanded(child: _buildPerformanceItem('Calls', '5426', '+158', const Color(0xFF10B981))),
              Expanded(child: _buildPerformanceItem('Engagement', '17%', '-3%', const Color(0xFFEF4444))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceItem(String label, String value, String change, Color changeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            change,
            style: TextStyle(
              color: changeColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildQuickActionItem(Icons.cloud_upload, 'Upload', () {
                Navigator.pushNamed(context, '/content_library');
              }),
              _buildQuickActionItem(Icons.live_tv, 'Live', () {}),
              _buildQuickActionItem(Icons.smart_toy, 'AI Bot', () {
                Navigator.pushNamed(context, '/ai_bot');
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF3A3A3A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF9500),
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsAnalytics() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Earnings Analytics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          // Chart Area
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: EarningsChartPainter(),
              size: const Size(double.infinity, 120),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Week Days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((day) => Text(
                      day,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ))
                .toList(),
          ),
          
          const SizedBox(height: 16),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Posts', 'Subs: \$650', 'Tips: \$250'),
              _buildStatItem('Monthly Goal', '\$7,500 / \$10,000', 'PPV: \$150'),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Bottom Navigation Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavIcon(Icons.home, true),
              _buildNavIcon(Icons.chat_bubble_outline, false),
              _buildNavIcon(Icons.phone, false),
              _buildNavIcon(Icons.account_balance_wallet, false),
              _buildNavIcon(Icons.explore, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value1, String value2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildNavIcon(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF9500) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.white : Colors.grey,
        size: 20,
      ),
    );
  }
}

class EarningsChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Chart background
    final backgroundPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;
    
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ),
      backgroundPaint,
    );

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (int i = 1; i < 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(
        Offset(20, y),
        Offset(size.width - 20, y),
        gridPaint,
      );
    }

    // Vertical grid lines
    for (int i = 1; i < 7; i++) {
      final x = 20 + (size.width - 40) * (i / 6);
      canvas.drawLine(
        Offset(x, 10),
        Offset(x, size.height - 10),
        gridPaint,
      );
    }

    // Create smooth curve data points
    final points = [
      Offset(20, size.height * 0.85),
      Offset(20 + (size.width - 40) * 0.16, size.height * 0.75),
      Offset(20 + (size.width - 40) * 0.33, size.height * 0.45),
      Offset(20 + (size.width - 40) * 0.5, size.height * 0.55),
      Offset(20 + (size.width - 40) * 0.66, size.height * 0.35),
      Offset(20 + (size.width - 40) * 0.83, size.height * 0.25),
      Offset(size.width - 20, size.height * 0.15),
    ];

    // Draw gradient fill under curve
    final gradientPath = Path();
    gradientPath.moveTo(points[0].dx, points[0].dy);
    
    // Create smooth curve using quadratic bezier
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint = Offset(
        current.dx + (next.dx - current.dx) * 0.5,
        current.dy,
      );
      gradientPath.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        next.dx,
        next.dy,
      );
    }
    
    // Close the path to create fill area
    gradientPath.lineTo(size.width - 20, size.height - 10);
    gradientPath.lineTo(20, size.height - 10);
    gradientPath.close();

    // Gradient fill
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFF9500).withOpacity(0.3),
          const Color(0xFFFF9500).withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(gradientPath, gradientPaint);

    // Draw the main curve line
    final linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint = Offset(
        current.dx + (next.dx - current.dx) * 0.5,
        current.dy,
      );
      linePath.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        next.dx,
        next.dy,
      );
    }

    final linePaint = Paint()
      ..color = const Color(0xFFFF9500)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(linePath, linePaint);

    // Draw data points
    final pointPaint = Paint()
      ..color = const Color(0xFFFF9500)
      ..style = PaintingStyle.fill;

    final pointBorderPaint = Paint()
      ..color = const Color(0xFF1A1A1A)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      // Draw white border
      canvas.drawCircle(point, 6, pointBorderPaint);
      // Draw orange center
      canvas.drawCircle(point, 4, pointPaint);
    }

    // Draw highlight on the highest point
    final highestPoint = points[6]; // Last point is highest
    final highlightPaint = Paint()
      ..color = const Color(0xFFFF9500).withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(highestPoint, 12, highlightPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
