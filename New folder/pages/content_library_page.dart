import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';

class ContentLibraryPage extends StatefulWidget {
  const ContentLibraryPage({super.key});

  @override
  State<ContentLibraryPage> createState() => _ContentLibraryPageState();
}

class _ContentLibraryPageState extends State<ContentLibraryPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 4; // Exclusive is index 4
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  final List<ContentItem> _images = [
    ContentItem(id: '1', type: 'image', thumbnail: 'honey_1', price: 30),
    ContentItem(id: '2', type: 'image', thumbnail: 'honey_2', price: 150),
    ContentItem(id: '3', type: 'image', thumbnail: 'honey_3', price: 45),
    ContentItem(id: '4', type: 'image', thumbnail: 'honey_4', price: 100),
    ContentItem(id: '5', type: 'image', thumbnail: 'honey_5', price: 250),
    ContentItem(id: '6', type: 'image', thumbnail: 'honey_6', price: 150),
  ];

  final List<ContentItem> _videos = [
    ContentItem(id: '7', type: 'video', thumbnail: 'honey_video_1', price: 200),
    ContentItem(id: '8', type: 'video', thumbnail: 'honey_video_2', price: 350),
    ContentItem(id: '9', type: 'video', thumbnail: 'honey_video_3', price: 150),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.info_outline, color: Colors.white),
          onPressed: () {
            _showInfoDialog();
          },
        ),
        title: const Text(
          'Content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: const Color(0xFFFF9500),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFFFF9500),
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Images'),
            Tab(text: 'Videos'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search content...',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: _showFilterOptions,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.grid_view, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          
          // Content Grid
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildContentGrid(_images),
                _buildContentGrid(_videos),
              ],
            ),
          ),
        ],
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_post_media');
        },
        backgroundColor: const Color(0xFFFF9500),
        child: const Icon(Icons.add, color: Colors.white),
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

  Widget _buildContentGrid(List<ContentItem> items) {
    List<ContentItem> filteredItems = items;
    
    if (_searchController.text.isNotEmpty) {
      filteredItems = items.where((item) => 
        item.id.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return _buildContentItem(filteredItems[index]);
        },
      ),
    );
  }

  Widget _buildContentItem(ContentItem item) {
    return GestureDetector(
      onTap: () {
        _showContentPreview(item);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Thumbnail
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
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
                child: item.type == 'video'
                    ? const Center(
                        child: Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : null,
              ),
              
              // Price Tag
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '\$${item.price}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              // More Options
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => _showContentOptions(item),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Content Library',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Manage your uploaded content. Create new posts, edit existing ones, and track your earnings.',
            style: TextStyle(color: Colors.grey),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Got it',
                style: TextStyle(color: Color(0xFFFF9500)),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildFilterOption('Price: Low to High'),
              _buildFilterOption('Price: High to Low'),
              _buildFilterOption('Recently Added'),
              _buildFilterOption('Most Popular'),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Apply Filters',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.check_box_outline_blank, color: Colors.grey),
      onTap: () {},
    );
  }

  void _showContentPreview(ContentItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFFA500).withOpacity(0.8),
                        const Color(0xFFFF8C00).withOpacity(0.6),
                        const Color(0xFFDAA520).withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: item.type == 'video'
                      ? const Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  '\$${item.price}',
                  style: const TextStyle(
                    color: Color(0xFFFF9500),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A3A3A),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/new_post_media');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9500),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showContentOptions(ContentItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionItem(Icons.edit, 'Edit Content', () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/new_post_media');
              }),
              _buildOptionItem(Icons.share, 'Share', () {
                Navigator.of(context).pop();
              }),
              _buildOptionItem(Icons.download, 'Download', () {
                Navigator.of(context).pop();
              }),
              _buildOptionItem(Icons.delete, 'Delete', () {
                Navigator.of(context).pop();
              }, isDestructive: true),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}

class ContentItem {
  final String id;
  final String type;
  final String thumbnail;
  final int price;

  ContentItem({
    required this.id,
    required this.type,
    required this.thumbnail,
    required this.price,
  });
}
