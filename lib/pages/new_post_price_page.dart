import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';

class NewPostPricePage extends StatefulWidget {
  const NewPostPricePage({super.key});

  @override
  State<NewPostPricePage> createState() => _NewPostPricePageState();
}

class _NewPostPricePageState extends State<NewPostPricePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _currentPrice = 199.0;
  bool _enableComments = true;
  bool _enableLikes = true;
  bool _enableViews = false;

  // Route arguments
  String _title = '';
  List<String> _tags = [];
  String _audience = '';

  final List<double> _quickPrices = [199, 999, 1999];
  final TextEditingController _customPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2); // Start on Price tab
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract route arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      _title = args['title'] ?? '';
      _tags = List<String>.from(args['tags'] ?? []);
      _audience = args['audience'] ?? '';
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _customPriceController.dispose();
    super.dispose();
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
          'New Post',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildProgressStep('Media', 0, false),
                const SizedBox(width: 8),
                _buildProgressStep('Details', 1, false),
                const SizedBox(width: 8),
                _buildProgressStep('Price', 2, true),
                const SizedBox(width: 8),
                _buildProgressStep('Review', 3, false),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildMediaTab(),
          _buildDetailsTab(),
          _buildPriceTab(),
          _buildReviewTab(),
        ],
      ),
    );
  }

  Widget _buildMediaTab() {
    return const Center(
      child: Text(
        'Media Tab - Go back to upload',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return const Center(
      child: Text(
        'Details Tab - Go back to edit',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildPriceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Set Your Price Header
          const Text(
            'Set Your Price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Current Price Display
          Center(
            child: CoinText(
              amount: _currentPrice.toStringAsFixed(2),
              textStyle: const TextStyle(
                color: Color(0xFFFF9500),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
              coinSize: 40,
              alignment: MainAxisAlignment.center,
            ),
          ),
          
          const SizedBox(height: 8),
          
          const Center(
            child: Text(
              'Post price',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Quick Price Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._quickPrices.map((price) => _buildQuickPriceButton(price)).toList(),
              _buildOtherPriceButton(),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Earnings Breakdown
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Earnings Breakdown',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                _buildEarningsRow('Your price', _currentPrice.toStringAsFixed(2), Colors.white, true),
                const SizedBox(height: 8),
                _buildEarningsRow('Influbee fee (10%)', '-${(_currentPrice * 0.1).toStringAsFixed(2)}', Colors.grey, true),
                const Divider(color: Colors.grey, height: 24),
                _buildEarningsRow('You will earn', (_currentPrice * 0.9).toStringAsFixed(2), const Color(0xFF4CAF50), true),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Additional Options
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Additional Options',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                _buildToggleOption(
                  'Enable Comments',
                  'Allow users to comment on this post',
                  _enableComments,
                  (value) => setState(() => _enableComments = value),
                ),
                const Divider(color: Colors.grey, height: 1),
                _buildToggleOption(
                  'Enable Likes',
                  'Show the like count on this post',
                  _enableLikes,
                  (value) => setState(() => _enableLikes = value),
                ),
                const Divider(color: Colors.grey, height: 1),
                _buildToggleOption(
                  'Views',
                  'Allow users to see view count on this post',
                  _enableViews,
                  (value) => setState(() => _enableViews = value),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: _goToReview,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickPriceButton(double price) {
    bool isSelected = _currentPrice == price;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPrice = price;
        });
      },
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9500) : const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF9500) : Colors.grey,
            width: 1,
          ),
        ),
        child: Center(
          child: CoinText(
            amount: '${price.toInt()}',
            textStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            coinSize: 12,
            alignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  Widget _buildOtherPriceButton() {
    return GestureDetector(
      onTap: _showCustomPriceDialog,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
        ),
        child: const Center(
          child: Text(
            'Other',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _showCustomPriceDialog() {
    _customPriceController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          title: const Text(
            'Enter Custom Price',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: _customPriceController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Enter price in coins',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(Icons.monetization_on, color: Color(0xFFFF9500), size: 16),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFF9500)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                double? customPrice = double.tryParse(_customPriceController.text);
                if (customPrice != null && customPrice > 0) {
                  setState(() {
                    _currentPrice = customPrice;
                  });
                  Navigator.of(context).pop();
                } else {
                  // Show error - invalid price
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid price'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Set Price',
                style: TextStyle(color: Color(0xFFFF9500)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEarningsRow(String title, String amount, Color amountColor, [bool showCoin = false]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        showCoin
          ? CoinText(
              amount: amount,
              textStyle: TextStyle(
                color: amountColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              coinSize: 12,
            )
          : Text(
              amount,
              style: TextStyle(
                color: amountColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
      ],
    );
  }

  Widget _buildToggleOption(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF9500),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTab() {
    return const Center(
      child: Text(
        'Review Tab - Coming soon',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildProgressStep(String title, int step, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? const Color(0xFFFF9500) : Colors.transparent,
              width: 3,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFFFF9500) : Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void _goToReview() {
    Navigator.pushNamed(
      context,
      '/review_publish',
      arguments: {
        'title': _title,
        'tags': _tags,
        'audience': _audience,
        'price': _currentPrice,
        'enableComments': _enableComments,
        'enableLikes': _enableLikes,
        'enableViews': _enableViews,
        'isSimpleReview': false, // This is premium content, so show tabs
      },
    );
  }
}
