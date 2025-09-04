import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';

class ExclusiveContentGalleryPage extends StatefulWidget {
  const ExclusiveContentGalleryPage({super.key});

  @override
  State<ExclusiveContentGalleryPage> createState() => _ExclusiveContentGalleryPageState();
}

class _ExclusiveContentGalleryPageState extends State<ExclusiveContentGalleryPage> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', 'Videos', 'Images'];
  
  // Mock data for exclusive content
  final List<ExclusiveContent> _allContent = [
    ExclusiveContent(
      id: '1',
      title: 'Beach Sunset Vibes',
      type: ContentType.image,
      thumbnail: 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
      price: 150,
      views: 1247,
      earnings: 187050,
      uploadDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    ExclusiveContent(
      id: '2',
      title: 'Morning Yoga Session',
      type: ContentType.video,
      thumbnail: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      price: 200,
      views: 892,
      earnings: 178400,
      uploadDate: DateTime.now().subtract(const Duration(days: 5)),
    ),
    ExclusiveContent(
      id: '3',
      title: 'Fashion Photoshoot',
      type: ContentType.image,
      thumbnail: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400',
      price: 180,
      views: 2156,
      earnings: 388080,
      uploadDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    ExclusiveContent(
      id: '4',
      title: 'Cooking Tutorial',
      type: ContentType.video,
      thumbnail: 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400',
      price: 250,
      views: 567,
      earnings: 141750,
      uploadDate: DateTime.now().subtract(const Duration(days: 3)),
    ),
    ExclusiveContent(
      id: '5',
      title: 'Travel Diary',
      type: ContentType.image,
      thumbnail: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400',
      price: 120,
      views: 1890,
      earnings: 226800,
      uploadDate: DateTime.now().subtract(const Duration(days: 7)),
    ),
    ExclusiveContent(
      id: '6',
      title: 'Dance Performance',
      type: ContentType.video,
      thumbnail: 'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=400',
      price: 300,
      views: 445,
      earnings: 133500,
      uploadDate: DateTime.now().subtract(const Duration(days: 4)),
    ),
  ];

  List<ExclusiveContent> get _filteredContent {
    if (_selectedFilter == 'All') return _allContent;
    return _allContent.where((content) {
      if (_selectedFilter == 'Videos') return content.type == ContentType.video;
      if (_selectedFilter == 'Images') return content.type == ContentType.image;
      return true;
    }).toList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        title: const Text(
          'Share Content',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // TODO: Implement search functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Tabs
          _buildFilterTabs(),
          
          // Content Grid
          Expanded(
            child: _filteredContent.isEmpty
                ? _buildEmptyState()
                : _buildContentGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFF9500) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  filter,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContentGrid() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _filteredContent.length,
      itemBuilder: (context, index) {
        final content = _filteredContent[index];
        return _buildContentCard(content);
      },
    );
  }

  Widget _buildContentCard(ExclusiveContent content) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3A3A3A),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail with type indicator
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    content.thumbnail,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF3A3A3A),
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
                // Content type indicator
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          content.type == ContentType.video ? Icons.play_circle : Icons.image,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          content.type == ContentType.video ? 'VIDEO' : 'IMAGE',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Play button overlay for videos
                if (content.type == ContentType.video)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Content details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  content.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                
                // Price and stats row
                Row(
                  children: [
                    // Price
                    CoinText(
                      amount: content.price.toString(),
                      textStyle: const TextStyle(
                        color: Color(0xFFFF9500),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      coinSize: 16,
                    ),
                    const Spacer(),
                    // Views
                    Row(
                      children: [
                        const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${content.views}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Share button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _shareContent(content),
                    icon: const Icon(Icons.share, size: 16),
                    label: const Text(
                      'Share in Chat',
                      style: TextStyle(fontSize: 12),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9500),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _selectedFilter == 'Videos' ? Icons.video_library : 
            _selectedFilter == 'Images' ? Icons.photo_library : 
            Icons.photo,
            color: Colors.grey,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            'No content available to share',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You need to create exclusive content first before sharing',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _shareContent(ExclusiveContent content) {
    // Directly return to chat with the selected content
    Navigator.of(context).pop({
      'sharedContent': content,
      'action': 'share',
    });
  }


}

// Data models
enum ContentType { video, image }

class ExclusiveContent {
  final String id;
  final String title;
  final ContentType type;
  final String thumbnail;
  final int price;
  final int views;
  final int earnings;
  final DateTime uploadDate;

  ExclusiveContent({
    required this.id,
    required this.title,
    required this.type,
    required this.thumbnail,
    required this.price,
    required this.views,
    required this.earnings,
    required this.uploadDate,
  });
}
