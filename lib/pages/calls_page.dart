import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/influbee_coin.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({super.key});

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  int _currentIndex = 2; // Calls is index 2
  String _selectedFilter = 'All';
  String _selectedCallType = 'All'; // All, Audio, Video

  final List<CallRecord> _allCalls = [
    CallRecord(
      name: 'Video Call with Maya',
      type: 'Completed - 00:34',
      amount: '25.00',
      rating: 5,
      date: 'TODAY',
      isVideo: true,
      avatar: 'M',
      avatarColor: const Color(0xFF8B5CF6),
    ),
    CallRecord(
      name: 'Audio Call with Alex',
      type: 'Completed - 00:12',
      amount: '7.00',
      rating: 4,
      date: 'TODAY',
      isVideo: false,
      avatar: 'A',
      avatarColor: const Color(0xFF06B6D4),
    ),
    CallRecord(
      name: 'Video Call with Chloe',
      type: 'Completed - 00:45',
      amount: '30.00',
      rating: 5,
      date: 'YESTERDAY',
      isVideo: true,
      avatar: 'C',
      avatarColor: const Color(0xFF10B981),
    ),
    CallRecord(
      name: 'Audio Call with Ethan',
      type: 'Completed - 00:28',
      amount: '15.00',
      rating: 4,
      date: 'OLDER',
      isVideo: false,
      avatar: 'E',
      avatarColor: const Color(0xFFF59E0B),
    ),
  ];

  List<CallRecord> get _filteredCalls {
    List<CallRecord> calls = _allCalls;
    
    // Filter by call status
    if (_selectedFilter == 'Missed Calls') {
      calls = []; // No missed calls in current data
    }
    
    // Filter by call type
    if (_selectedCallType == 'Audio') {
      calls = calls.where((call) => !call.isVideo).toList();
    } else if (_selectedCallType == 'Video') {
      calls = calls.where((call) => call.isVideo).toList();
    }
    
    return calls;
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
          'Calls',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Stats Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('12', 'Total Calls'),
                _buildStatItem('245', 'Minutes'),
                _buildStatItem('70', 'Earnings'),
              ],
            ),
          ),

          // Filter Options
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'All';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedFilter == 'All' 
                            ? const Color(0xFFFF9500) 
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'All',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedFilter == 'All' ? Colors.white : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = 'Missed Calls';
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _selectedFilter == 'Missed Calls' 
                            ? const Color(0xFFFF9500) 
                            : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Missed Calls',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectedFilter == 'Missed Calls' ? Colors.white : Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Filter Icon
                GestureDetector(
                  onTap: _showCallTypeFilter,
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



          const SizedBox(height: 24),

          // Call History
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _getGroupedCalls().length,
              itemBuilder: (context, index) {
                final group = _getGroupedCalls()[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (group['header'] != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, bottom: 8, top: 16),
                        child: Text(
                          group['header'],
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ...group['calls'].map<Widget>((call) => _buildCallItem(call)),
                  ],
                );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/incoming_call');
        },
        backgroundColor: const Color(0xFFFF9500),
        child: const Icon(Icons.add_call, color: Colors.white),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        label == 'Earnings'
          ? CoinText(
              amount: value,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              coinSize: 20,
              alignment: MainAxisAlignment.center,
            )
          : Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCallItem(CallRecord call) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/incoming_call', arguments: call);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
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
                color: call.avatarColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  call.avatar,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        call.type,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < call.rating 
                                ? const Color(0xFFFF9500) 
                                : Colors.grey,
                            size: 12,
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CoinText(
              amount: call.amount,
              textStyle: const TextStyle(
                color: Color(0xFF10B981),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              coinSize: 14,
            ),
          ],
        ),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 20,
            ),
          ),
          _buildBottomBarItem(Icons.chat_outlined, false),
          _buildBottomBarItem(Icons.account_balance_wallet_outlined, false),
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

  List<Map<String, dynamic>> _getGroupedCalls() {
    final Map<String, List<CallRecord>> grouped = {};
    
    for (final call in _filteredCalls) {
      if (!grouped.containsKey(call.date)) {
        grouped[call.date] = [];
      }
      grouped[call.date]!.add(call);
    }

    final List<Map<String, dynamic>> result = [];
    
    for (final entry in grouped.entries) {
      result.add({
        'header': entry.key,
        'calls': entry.value,
      });
    }

    return result;
  }

  void _showCallTypeFilter() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        size.width - 200, // Position from right edge
        offset.dy + 120, // Position below filter section
        size.width - 16,  // Right edge with padding
        offset.dy + 300,  // Bottom boundary
      ),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
      ),
      elevation: 8,
      items: [
        _buildDropdownItem('All', Icons.all_inclusive, const Color(0xFF6B7280)),
        _buildDropdownItem('Audio', Icons.headset_mic, const Color(0xFFFF9500)),
        _buildDropdownItem('Video', Icons.videocam, const Color(0xFF8B5CF6)),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedCallType = value;
        });
      }
    });
  }

  PopupMenuItem<String> _buildDropdownItem(String title, IconData icon, Color color) {
    final isSelected = _selectedCallType == title;
    
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
}

class CallRecord {
  final String name;
  final String type;
  final String amount;
  final int rating;
  final String date;
  final bool isVideo;
  final String avatar;
  final Color avatarColor;

  CallRecord({
    required this.name,
    required this.type,
    required this.amount,
    required this.rating,
    required this.date,
    required this.isVideo,
    required this.avatar,
    required this.avatarColor,
  });
}
