import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/influbee_coin.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _currentIndex = 3; // Wallet is index 3
  String _selectedFilter = 'All';
  String _selectedSubFilter = 'All'; // For Content and Gifts sub-filters
  
  final List<Transaction> _allTransactions = [
    Transaction(
      title: 'Audio Call',
      subtitle: 'Call with @user123',
      amount: '+25.00',
      date: 'Oct 30, 2023',
      type: 'earning',
      category: 'audio',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Video Call',
      subtitle: 'Call with @sarah',
      amount: '+45.00',
      date: 'Oct 30, 2023',
      type: 'earning',
      category: 'video',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Premium Call',
      subtitle: 'Premium call with @alex',
      amount: '+100.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'premium',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Live Stream',
      subtitle: 'Live session earnings',
      amount: '+75.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'live',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Subscription',
      subtitle: 'Monthly subscription',
      amount: '+200.00',
      date: 'Oct 28, 2023',
      type: 'earning',
      category: 'subscription',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Gift - Live',
      subtitle: 'Gift received during live',
      amount: '+50.00',
      date: 'Oct 28, 2023',
      type: 'earning',
      category: 'gifts',
      subCategory: 'live',
    ),
    Transaction(
      title: 'Gift - Message',
      subtitle: 'Gift in chat message',
      amount: '+20.00',
      date: 'Oct 27, 2023',
      type: 'earning',
      category: 'gifts',
      subCategory: 'message',
    ),
    Transaction(
      title: 'Gift - Video Call',
      subtitle: 'Gift during video call',
      amount: '+80.00',
      date: 'Oct 27, 2023',
      type: 'earning',
      category: 'gifts',
      subCategory: 'videocall',
    ),
    Transaction(
      title: 'Image Content',
      subtitle: 'Photo sold to @mike',
      amount: '+35.00',
      date: 'Oct 26, 2023',
      type: 'earning',
      category: 'content',
      subCategory: 'image',
    ),
    Transaction(
      title: 'Video Content',
      subtitle: 'Video sold to @anna',
      amount: '+60.00',
      date: 'Oct 26, 2023',
      type: 'earning',
      category: 'content',
      subCategory: 'video',
    ),
    Transaction(
      title: 'Bank Withdrawal',
      subtitle: 'Transferred to bank account',
      amount: '-500.00',
      date: 'Oct 25, 2023',
      type: 'withdrawal',
      category: 'withdrawal',
      subCategory: 'all',
    ),
    Transaction(
      title: 'Withdrawal Request',
      subtitle: 'Cash out earnings',
      amount: '-250.00',
      date: 'Oct 24, 2023',
      type: 'withdrawal',
      category: 'withdrawal',
      subCategory: 'all',
    ),
  ];

  List<Transaction> get _filteredTransactions {
    if (_selectedFilter == 'All') return _allTransactions;
    
    List<Transaction> filtered = [];
    
    if (_selectedFilter == 'Calls') {
      // For Calls, include audio, video, and premium transactions
      filtered = _allTransactions.where((transaction) => 
        ['audio', 'video', 'premium'].contains(transaction.category.toLowerCase())).toList();
      
      // Apply sub-filter for Calls
      if (_selectedSubFilter != 'All') {
        filtered = filtered.where((transaction) => 
          transaction.category.toLowerCase() == _selectedSubFilter.toLowerCase()).toList();
      }
    } else {
      // For other filters, match category directly
      filtered = _allTransactions.where((transaction) => 
        transaction.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
      
      // Apply sub-filter for Content and Gifts
      if ((_selectedFilter == 'Content' || _selectedFilter == 'Gifts') && _selectedSubFilter != 'All') {
        filtered = filtered.where((transaction) => 
          transaction.subCategory.toLowerCase() == _selectedSubFilter.toLowerCase()).toList();
      }
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (route) => false,
          ),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Current Balance Section (Compact)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Balance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                CoinText(
                  amount: '1,234.56',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  coinSize: 24,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '+12.5% this week',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Earnings Graph Section (Compact)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: _buildEarningsGraph(),
          ),

          // Transactions Header with Filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: _showFilterModal,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Transactions List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                return _buildTransactionItem(transaction);
              },
            ),
          ),
        ],
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

  Widget _buildTransactionItem(Transaction transaction) {
    IconData icon;
    Color iconColor;
    Color backgroundColor;

    switch (transaction.category) {
      case 'calls':
        icon = Icons.phone;
        iconColor = const Color(0xFFFF9500);
        backgroundColor = const Color(0xFFFF9500).withOpacity(0.1);
        break;
      case 'messages':
        icon = Icons.message;
        iconColor = const Color(0xFF8B5CF6);
        backgroundColor = const Color(0xFF8B5CF6).withOpacity(0.1);
        break;
      case 'content':
        icon = Icons.image;
        iconColor = const Color(0xFF10B981);
        backgroundColor = const Color(0xFF10B981).withOpacity(0.1);
        break;
      default:
        icon = transaction.type == 'deposit' ? Icons.add : Icons.remove;
        iconColor = transaction.type == 'deposit' ? const Color(0xFF10B981) : const Color(0xFFEF4444);
        backgroundColor = iconColor.withOpacity(0.1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CoinText(
                amount: transaction.amount,
                textStyle: TextStyle(
                  color: transaction.amount.startsWith('+') 
                      ? const Color(0xFF10B981) 
                      : const Color(0xFFEF4444),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                coinSize: 14,
                alignment: MainAxisAlignment.end,
              ),
              const SizedBox(height: 2),
              Text(
                transaction.date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarItem(Icons.home_outlined, false),
          _buildBottomBarItem(Icons.phone_outlined, false),
          _buildBottomBarItem(Icons.chat_outlined, false),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.account_balance_wallet,
              color: Colors.white,
              size: 20,
            ),
          ),
          _buildBottomBarItem(Icons.image_outlined, false),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: isActive ? const Color(0xFFFF9500) : Colors.grey,
        size: 24,
      ),
    );
  }

  void _showFilterModal() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        size.width - 220, // Position from right edge (wider for more options)
        offset.dy + 180, // Position below transactions header
        size.width - 16,  // Right edge with padding
        offset.dy + 450,  // Bottom boundary (taller for more options)
      ),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
      ),
      elevation: 8,
      items: [
        _buildFilterDropdownItem('All', Icons.all_inclusive, const Color(0xFF6B7280)),
        _buildFilterDropdownItemWithSubMenu('Calls', Icons.phone, const Color(0xFFFF9500)),
        _buildFilterDropdownItem('Live', Icons.live_tv, const Color(0xFFFF4444)),
        _buildFilterDropdownItem('Subscription', Icons.subscriptions, const Color(0xFF00BCD4)),
        _buildFilterDropdownItem('Withdrawal', Icons.account_balance_wallet, const Color(0xFFFF6B6B)),
        _buildFilterDropdownItemWithSubMenu('Gifts', Icons.card_giftcard, const Color(0xFFE91E63)),
        _buildFilterDropdownItemWithSubMenu('Content', Icons.image, const Color(0xFF10B981)),
      ],
    ).then((value) {
      if (value != null) {
        if (value == 'Content' || value == 'Gifts' || value == 'Calls') {
          _showSubFilterModal(value);
        } else {
          setState(() {
            _selectedFilter = value;
            _selectedSubFilter = 'All';
          });
        }
      }
    });
  }

  PopupMenuItem<String> _buildFilterDropdownItem(String title, IconData icon, Color color) {
    final isSelected = _selectedFilter == title;
    
    return PopupMenuItem<String>(
      value: title,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xFFFF9500),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildFilterDropdownItemWithSubMenu(String title, IconData icon, Color color) {
    final isSelected = _selectedFilter == title;
    
    return PopupMenuItem<String>(
      value: title,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  const Icon(
                    Icons.check,
                    color: Color(0xFFFF9500),
                    size: 16,
                  ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSubFilterModal(String mainFilter) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    
    List<Map<String, dynamic>> subOptions = [];
    
    if (mainFilter == 'Content') {
      subOptions = [
        {'title': 'All', 'icon': Icons.all_inclusive, 'color': const Color(0xFF6B7280)},
        {'title': 'Image', 'icon': Icons.image, 'color': const Color(0xFF10B981)},
        {'title': 'Video', 'icon': Icons.play_circle, 'color': const Color(0xFF8B5CF6)},
      ];
    } else if (mainFilter == 'Gifts') {
      subOptions = [
        {'title': 'All', 'icon': Icons.all_inclusive, 'color': const Color(0xFF6B7280)},
        {'title': 'Live', 'icon': Icons.live_tv, 'color': const Color(0xFFFF4444)},
        {'title': 'Message', 'icon': Icons.message, 'color': const Color(0xFF00BCD4)},
        {'title': 'Videocall', 'icon': Icons.video_call, 'color': const Color(0xFFFFD700)},
      ];
    } else if (mainFilter == 'Calls') {
      subOptions = [
        {'title': 'All', 'icon': Icons.all_inclusive, 'color': const Color(0xFF6B7280)},
        {'title': 'Audio', 'icon': Icons.headset_mic, 'color': const Color(0xFFFF9500)},
        {'title': 'Video', 'icon': Icons.videocam, 'color': const Color(0xFF8B5CF6)},
        {'title': 'Premium', 'icon': Icons.star, 'color': const Color(0xFFFFD700)},
      ];
    }
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        size.width - 200,
        offset.dy + 180,
        size.width - 16,
        offset.dy + 350,
      ),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
      ),
      elevation: 8,
      items: subOptions.map((option) => 
        _buildSubFilterDropdownItem(
          option['title'], 
          option['icon'], 
          option['color'], 
          mainFilter
        )
      ).toList(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedFilter = mainFilter;
          _selectedSubFilter = value;
        });
      }
    });
  }

  PopupMenuItem<String> _buildSubFilterDropdownItem(String title, IconData icon, Color color, String mainFilter) {
    final isSelected = _selectedFilter == mainFilter && _selectedSubFilter == title;
    
    return PopupMenuItem<String>(
      value: title,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xFFFF9500),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarningsGraph() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Earnings Analytics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Graph Area
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomPaint(
              painter: WalletEarningsChartPainter(),
              size: const Size(double.infinity, 100),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Week Days (all 7 days)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map((day) => Text(
                      day,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class WalletEarningsChartPainter extends CustomPainter {
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

    // Create wavy curve data points for last 7 days
    final points = [
      Offset(15, size.height * 0.8),           // Mon - Lower
      Offset(15 + (size.width - 30) * 0.16, size.height * 0.6),  // Tue - Higher
      Offset(15 + (size.width - 30) * 0.33, size.height * 0.3),  // Wed - Peak
      Offset(15 + (size.width - 30) * 0.5, size.height * 0.45),  // Thu - Down
      Offset(15 + (size.width - 30) * 0.66, size.height * 0.25), // Fri - High
      Offset(15 + (size.width - 30) * 0.83, size.height * 0.5),  // Sat - Down
      Offset(size.width - 15, size.height * 0.2),       // Sun - Peak
    ];

    // Draw gradient fill under curve
    final gradientPath = Path();
    gradientPath.moveTo(points[0].dx, points[0].dy);
    
    // Create smooth wavy curve using cubic bezier
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) * 0.3,
        current.dy + (next.dy - current.dy) * 0.1,
      );
      final controlPoint2 = Offset(
        current.dx + (next.dx - current.dx) * 0.7,
        current.dy + (next.dy - current.dy) * 0.9,
      );
      gradientPath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        next.dx,
        next.dy,
      );
    }
    
    // Close the path to create fill area
    gradientPath.lineTo(size.width - 15, size.height - 5);
    gradientPath.lineTo(15, size.height - 5);
    gradientPath.close();

    // Gradient fill
    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFFF9500).withOpacity(0.4),
          const Color(0xFFFF9500).withOpacity(0.1),
          const Color(0xFFFF9500).withOpacity(0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(gradientPath, gradientPaint);

    // Draw the wavy line
    final linePaint = Paint()
      ..color = const Color(0xFFFF9500)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint1 = Offset(
        current.dx + (next.dx - current.dx) * 0.3,
        current.dy + (next.dy - current.dy) * 0.1,
      );
      final controlPoint2 = Offset(
        current.dx + (next.dx - current.dx) * 0.7,
        current.dy + (next.dy - current.dy) * 0.9,
      );
      linePath.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        next.dx,
        next.dy,
      );
    }

    canvas.drawPath(linePath, linePaint);

    // Draw data points with smaller size for compact view
    final pointPaint = Paint()
      ..color = const Color(0xFFFF9500)
      ..style = PaintingStyle.fill;

    final glowPaint = Paint()
      ..color = const Color(0xFFFF9500).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    for (final point in points) {
      // Draw glow
      canvas.drawCircle(point, 4, glowPaint);
      // Draw point
      canvas.drawCircle(point, 2, pointPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String type;
  final String category;
  final String subCategory;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    required this.subCategory,
  });
}
