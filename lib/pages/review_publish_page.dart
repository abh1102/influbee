import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';

class ReviewPublishPage extends StatefulWidget {
  const ReviewPublishPage({super.key});

  @override
  State<ReviewPublishPage> createState() => _ReviewPublishPageState();
}

class _ReviewPublishPageState extends State<ReviewPublishPage> {
  bool _scheduledPost = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  
  // Content details from route arguments
  String title = '';
  List<String> tags = [];
  String audience = '';
  double price = 0.0;
  bool enableComments = true;
  bool enableLikes = true;
  bool enableViews = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract route arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      final newTitle = args['title'] ?? '';
      final newTags = List<String>.from(args['tags'] ?? []);
      final newAudience = args['audience'] ?? '';
      final newPrice = args['price'] ?? 0.0;
      final newEnableComments = args['enableComments'] ?? true;
      final newEnableViews = args['enableViews'] ?? true;
      
      // Update state
      setState(() {
        title = newTitle;
        tags = newTags;
        audience = newAudience;
        price = newPrice;
        enableComments = newEnableComments;
        enableLikes = newEnableViews;
        enableViews = newEnableViews;
      });
    }
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
                _buildProgressStep('Price', 2, false),
                const SizedBox(width: 8),
                _buildProgressStep('Review', 3, true),
              ],
            ),
          ),
        ),
      ),
      body: _buildSimpleReviewTab(), // Use simple review for all content types
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

  Widget _buildSimpleReviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content Preview Section
          const Text(
            'Content Preview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Preview Card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                // Media Preview
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFA500).withOpacity(0.8),
                        const Color(0xFFFF8C00).withOpacity(0.6),
                        const Color(0xFFDAA520).withOpacity(0.4),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_outline,
                      color: Colors.white,
                      size: 80,
                    ),
                  ),
                ),
                
                // Content Info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFF8B5CF6),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'JD',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
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
                                  'Your Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Just now',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (audience == 'premium')
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF9500),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: CoinText(
                                amount: price.toStringAsFixed(0),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                coinSize: 12,
                              ),
                            )
                          else
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: audience == 'subscription' 
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFF6B7280),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                audience == 'subscription' ? 'SUBSCRIPTION' : 'FREE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        title.isNotEmpty ? title : 'Your amazing content title...',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (tags.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          tags.map((tag) => '#$tag').join(' '),
                          style: const TextStyle(
                            color: Color(0xFFFF9500),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Summary Section
          const Text(
            'Summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Title:', title.isNotEmpty ? title : 'Not specified'),
                const SizedBox(height: 12),
                _buildSummaryRow('Tags:', tags.isNotEmpty ? tags.map((tag) => '#$tag').join(' ') : 'None'),
                const SizedBox(height: 12),
                _buildSummaryRow('Audience:', _getAudienceDisplayName()),
                const SizedBox(height: 12),
                if (audience == 'premium') ...[
                  _buildSummaryRowWithCoin('Price:', price),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Publishing Options
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _saveAsDraft,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save as Draft',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _publishNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Publish Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: _schedulePost,
                  icon: const Icon(Icons.schedule, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRowWithCoin(String label, double amount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: CoinText(
            amount: amount.toStringAsFixed(0),
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            coinSize: 14,
          ),
        ),
      ],
    );
  }

  String _getAudienceDisplayName() {
    switch (audience) {
      case 'premium':
        return 'Premium Members Only';
      case 'subscription':
        return 'Subscribers Only';
      case 'public':
        return 'Public - Everyone';
      default:
        return 'Not specified';
    }
  }



  void _saveAsDraft() {
    _showSuccessDialog(
      'Draft Saved!',
      'Your post has been saved as a draft. You can continue editing it later.',
      'Got it',
    );
  }

  void _publishNow() {
    _showSuccessDialog(
      'Post Published!',
      'Your content is now live and available to your audience.',
      'View Post',
    );
  }

  void _schedulePost() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Schedule Post',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Date Picker
                  ListTile(
                    leading: const Icon(Icons.calendar_today, color: Color(0xFFFF9500)),
                    title: const Text('Date', style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setModalState(() {
                          _selectedDate = date;
                        });
                      }
                    },
                  ),
                  
                  // Time Picker
                  ListTile(
                    leading: const Icon(Icons.access_time, color: Color(0xFFFF9500)),
                    title: const Text('Time', style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (time != null) {
                        setModalState(() {
                          _selectedTime = time;
                        });
                      }
                    },
                  ),
                  
                  const SizedBox(height: 20),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showSuccessDialog(
                          'Post Scheduled!',
                          'Your post will be published on ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} at ${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                          'Great',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9500),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Schedule',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(String title, String message, String buttonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
