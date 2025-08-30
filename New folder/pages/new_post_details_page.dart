import 'package:flutter/material.dart';

class NewPostDetailsPage extends StatefulWidget {
  const NewPostDetailsPage({super.key});

  @override
  State<NewPostDetailsPage> createState() => _NewPostDetailsPageState();
}

class _NewPostDetailsPageState extends State<NewPostDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  
  String _selectedCategory = '';
  String _selectedAudience = '';
  final List<String> _tags = [];
  final List<String> _suggestedTags = ['honey', 'bbee', 'nectar'];
  bool _isPremium = false;
  bool _isPublicPreview = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(1); // Start on Details tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          const Text(
            'Title',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white),
              maxLength: 100,
              decoration: const InputDecoration(
                hintText: 'e.g., My Latest Honey Haul',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                counterStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Description Section
          const Text(
            'Description',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _descriptionController,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Describe your post...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Categories Section
          const Text(
            'Categories',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonFormField<String>(
              value: _selectedCategory.isEmpty ? null : _selectedCategory,
              dropdownColor: const Color(0xFF2A2A2A),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Select a category',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
                suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
              ),
              items: ['Lifestyle', 'Food', 'Nature', 'Education', 'Entertainment']
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value ?? '';
                });
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Tags Section
          const Text(
            'Tags',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _tagsController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Add tags separated by commas',
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFFFF9500)),
                  onPressed: _addTags,
                ),
              ),
              onSubmitted: (_) => _addTags(),
            ),
          ),
          
          // Suggested Tags
          if (_suggestedTags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: _suggestedTags.map((tag) => GestureDetector(
                onTap: () => _addSuggestedTag(tag),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9500).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF9500),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add, color: Color(0xFFFF9500), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        tag,
                        style: const TextStyle(
                          color: Color(0xFFFF9500),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ],
          
          // Current Tags
          if (_tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: _tags.map((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => _removeTag(tag),
                      child: const Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ],
          
          const SizedBox(height: 24),
          
          // Audience Section
          const Text(
            'Audience',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildAudienceOption(
                  Icons.public,
                  'Public',
                  'Everyone can see',
                  'public',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAudienceOption(
                  Icons.people,
                  'Followers',
                  'Only followers',
                  'followers',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildAudienceOption(
                  Icons.location_on,
                  'Location',
                  'Location based',
                  'location',
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Premium Options
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildToggleOption(
                  'Premium',
                  'Paid content for premium subscribers',
                  _isPremium,
                  (value) => setState(() => _isPremium = value),
                ),
                const Divider(color: Colors.grey, height: 1),
                _buildToggleOption(
                  'Public Preview',
                  'A short preview available to everyone',
                  _isPublicPreview,
                  (value) => setState(() => _isPublicPreview = value),
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
                  onPressed: () => _tabController.animateTo(0),
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
                  onPressed: _isFormValid() ? _goToPrice : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFormValid() 
                        ? const Color(0xFFFF9500) 
                        : const Color(0xFF3A3A3A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: _isFormValid() ? Colors.white : Colors.grey,
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

  Widget _buildAudienceOption(IconData icon, String title, String subtitle, String value) {
    bool isSelected = _selectedAudience == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAudience = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFF9500).withOpacity(0.2) : const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF9500) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFFF9500) : Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFF9500) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.grey),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFFF9500),
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  Widget _buildPriceTab() {
    return const Center(
      child: Text(
        'Price Tab - Coming soon',
        style: TextStyle(color: Colors.white),
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

  void _addTags() {
    String text = _tagsController.text.trim();
    if (text.isNotEmpty) {
      List<String> newTags = text.split(',').map((tag) => tag.trim()).where((tag) => tag.isNotEmpty).toList();
      setState(() {
        _tags.addAll(newTags.where((tag) => !_tags.contains(tag)));
        _tagsController.clear();
      });
    }
  }

  void _addSuggestedTag(String tag) {
    if (!_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _suggestedTags.remove(tag);
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
      if (!_suggestedTags.contains(tag)) {
        _suggestedTags.add(tag);
      }
    });
  }

  bool _isFormValid() {
    return _titleController.text.isNotEmpty &&
           _descriptionController.text.isNotEmpty &&
           _selectedCategory.isNotEmpty &&
           _selectedAudience.isNotEmpty;
  }

  void _goToPrice() {
    Navigator.pushNamed(
      context,
      '/new_post_price',
      arguments: {
        'title': _titleController.text,
        'description': _descriptionController.text,
        'category': _selectedCategory,
        'tags': _tags,
        'audience': _selectedAudience,
        'isPremium': _isPremium,
        'isPublicPreview': _isPublicPreview,
      },
    );
  }
}
