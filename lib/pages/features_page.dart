import 'package:flutter/material.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  bool _exclusiveContent = true;
  bool _videoCall = true;
  bool _audioCall = false;
  bool _subscription = false;

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
          'Features',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildFeatureItem(
            'Exclusive Content',
            _exclusiveContent,
            (value) {
              setState(() {
                _exclusiveContent = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            'Video Call',
            _videoCall,
            (value) {
              setState(() {
                _videoCall = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            'Audio Call',
            _audioCall,
            (value) {
              setState(() {
                _audioCall = value;
              });
            },
          ),
          const SizedBox(height: 8),
          _buildFeatureItem(
            'Subscription',
            _subscription,
            (value) {
              setState(() {
                _subscription = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String title, bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFFFF9500),
            activeTrackColor: const Color(0xFFFF9500).withOpacity(0.3),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
