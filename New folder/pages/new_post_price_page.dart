import 'package:flutter/material.dart';

class NewPostPricePage extends StatefulWidget {
  const NewPostPricePage({super.key});

  @override
  State<NewPostPricePage> createState() => _NewPostPricePageState();
}

class _NewPostPricePageState extends State<NewPostPricePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _currentPrice = 35.0;
  bool _enableComments = true;
  bool _enableLikes = true;
  bool _ageRestriction = false;

  final List<double> _quickPrices = [15, 35, 50];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(2); // Start on Price tab
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFFF9500),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFFF9500),
          indicatorWeight: 3,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Media'),
            Tab(text: 'Details'),
            Tab(text: 'Price'),
            Tab(text: 'Review'),
          ],
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
            child: Text(
              '\$${_currentPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Color(0xFFFF9500),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
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
            children: _quickPrices.map((price) => _buildQuickPriceButton(price)).toList(),
          ),
          
          const SizedBox(height: 24),
          
          // Price Slider
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '\$5',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '\$${_currentPrice.toInt()}',
                      style: const TextStyle(
                        color: Color(0xFFFF9500),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      '\$100',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFFFF9500),
                    inactiveTrackColor: Colors.grey.withOpacity(0.3),
                    thumbColor: const Color(0xFFFF9500),
                    overlayColor: const Color(0xFFFF9500).withOpacity(0.2),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _currentPrice,
                    min: 5,
                    max: 100,
                    divisions: 19,
                    onChanged: (value) {
                      setState(() {
                        _currentPrice = value;
                      });
                    },
                  ),
                ),
              ],
            ),
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
                _buildEarningsRow('Your price', '\$${_currentPrice.toStringAsFixed(2)}', Colors.white),
                const SizedBox(height: 8),
                _buildEarningsRow('Influbee fee (10%)', '-\$${(_currentPrice * 0.1).toStringAsFixed(2)}', Colors.grey),
                const Divider(color: Colors.grey, height: 24),
                _buildEarningsRow('You will earn', '\$${(_currentPrice * 0.9).toStringAsFixed(2)}', const Color(0xFF4CAF50)),
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
                  'Age Restriction',
                  'Set minimum age to view this post',
                  _ageRestriction,
                  (value) => setState(() => _ageRestriction = value),
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
          child: Text(
            '\$${price.toInt()}',
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEarningsRow(String title, String amount, Color amountColor) {
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
        Text(
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

  void _goToReview() {
    Navigator.pushNamed(
      context,
      '/review_publish',
      arguments: {
        'price': _currentPrice,
        'enableComments': _enableComments,
        'enableLikes': _enableLikes,
        'ageRestriction': _ageRestriction,
      },
    );
  }
}
