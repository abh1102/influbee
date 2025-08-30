import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  int _currentIndex = 3; // Wallet is index 3
  String _selectedFilter = 'All';
  
  final List<Transaction> _allTransactions = [
    Transaction(
      title: 'Funds Added',
      subtitle: 'From Bank Account',
      amount: '+\$250.00',
      date: 'Oct 30, 2023',
      type: 'deposit',
      category: 'funds',
    ),
    Transaction(
      title: 'Withdrawal',
      subtitle: 'To Bank Account',
      amount: '-\$50.00',
      date: 'Oct 30, 2023',
      type: 'withdrawal',
      category: 'funds',
    ),
    Transaction(
      title: 'Call with @user123',
      subtitle: 'Earning',
      amount: '+\$25.00',
      date: 'Oct 30, 2023',
      type: 'earning',
      category: 'calls',
    ),
    Transaction(
      title: 'Message from @sarah',
      subtitle: 'Content Purchase',
      amount: '+\$15.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'messages',
    ),
    Transaction(
      title: 'Content Sale',
      subtitle: 'Photo sold to @mike',
      amount: '+\$35.00',
      date: 'Oct 29, 2023',
      type: 'earning',
      category: 'content',
    ),
  ];

  List<Transaction> get _filteredTransactions {
    if (_selectedFilter == 'All') return _allTransactions;
    return _allTransactions.where((transaction) => 
      transaction.category.toLowerCase() == _selectedFilter.toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
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
          // Available Balance Section
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$1,234.56',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9500),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add Funds',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          side: const BorderSide(color: Color(0xFFFF9500)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Withdraw',
                          style: TextStyle(
                            color: Color(0xFFFF9500),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
              Text(
                transaction.amount,
                style: TextStyle(
                  color: transaction.amount.startsWith('+') 
                      ? const Color(0xFF10B981) 
                      : const Color(0xFFEF4444),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Handle bar
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter by',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Filter Options
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          _buildFilterOption(
                            'All',
                            Icons.all_inclusive,
                            const Color(0xFF6B7280),
                            setModalState,
                          ),
                          _buildFilterOption(
                            'Calls',
                            Icons.phone,
                            const Color(0xFFFF9500),
                            setModalState,
                          ),
                          _buildFilterOption(
                            'Messages',
                            Icons.message,
                            const Color(0xFF8B5CF6),
                            setModalState,
                          ),
                          _buildFilterOption(
                            'Content',
                            Icons.image,
                            const Color(0xFF10B981),
                            setModalState,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      // Refresh the main page when modal closes
      setState(() {});
    });
  }

  Widget _buildFilterOption(String title, IconData icon, Color color, StateSetter setModalState) {
    final isSelected = _selectedFilter == title;
    
    return GestureDetector(
      onTap: () {
        setModalState(() {
          _selectedFilter = title;
        });
        setState(() {
          _selectedFilter = title;
        });
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2A2A2A) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: const Color(0xFFFF9500), width: 1) : null,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Color(0xFFFF9500),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String title;
  final String subtitle;
  final String amount;
  final String date;
  final String type;
  final String category;

  Transaction({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });
}
