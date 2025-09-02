import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/influbee_coin.dart';

class ContentLibraryPage extends StatefulWidget {
  const ContentLibraryPage({super.key});

  @override
  State<ContentLibraryPage> createState() => _ContentLibraryPageState();
}

class _ContentLibraryPageState extends State<ContentLibraryPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 4; // Exclusive is index 4
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedSortFilter = 'Recently Added';

  final List<ContentItem> _images = [
    ContentItem(id: '1', type: 'image', thumbnail: 'honey_1', price: 30, title: 'Sunset Vibes'),
    ContentItem(id: '2', type: 'image', thumbnail: 'honey_2', price: 150, title: 'Golden Hour'),
    ContentItem(id: '3', type: 'image', thumbnail: 'honey_3', price: 45, title: 'Beach Day'),
    ContentItem(id: '4', type: 'image', thumbnail: 'honey_4', price: 100, title: 'City Lights'),
    ContentItem(id: '5', type: 'image', thumbnail: 'honey_5', price: 250, title: 'Premium Collection'),
    ContentItem(id: '6', type: 'image', thumbnail: 'honey_6', price: 150, title: 'Nature Walk'),
  ];

  final List<ContentItem> _videos = [
    ContentItem(id: '7', type: 'video', thumbnail: 'honey_video_1', price: 200, title: 'Dance Performance'),
    ContentItem(id: '8', type: 'video', thumbnail: 'honey_video_2', price: 350, title: 'Exclusive Behind Scenes'),
    ContentItem(id: '9', type: 'video', thumbnail: 'honey_video_3', price: 150, title: 'Morning Routine'),
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
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (route) => false,
          ),
        ),
        title: const Text(
          'Content',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [],
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
    
    // Apply search filter
    if (_searchController.text.isNotEmpty) {
      filteredItems = items.where((item) => 
        item.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
        item.id.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    // Apply sorting
    switch (_selectedSortFilter) {
      case 'Price: Low to High':
        filteredItems.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price: High to Low':
        filteredItems.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Most Popular':
        filteredItems.sort((a, b) => b.price.compareTo(a.price)); // Sort by price as popularity indicator
        break;
      case 'Recently Added':
      default:
        // Keep original order (recently added first)
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85, // Adjusted to accommodate title
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content Card
          Expanded(
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
                        child: CoinText(
                          amount: '${item.price}',
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          coinSize: 10,
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
          ),
          // Title
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        size.width - 200, // Position from right edge
        offset.dy + 140, // Position below search/filter section
        size.width - 16,  // Right edge with padding
        offset.dy + 350,  // Bottom boundary
      ),
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF3A3A3A), width: 1),
      ),
      elevation: 8,
      items: [
        _buildSortDropdownItem('Recently Added', Icons.schedule, const Color(0xFF10B981)),
        _buildSortDropdownItem('Price: Low to High', Icons.trending_up, const Color(0xFF00BCD4)),
        _buildSortDropdownItem('Price: High to Low', Icons.trending_down, const Color(0xFFFF6B6B)),
        _buildSortDropdownItem('Most Popular', Icons.star, const Color(0xFFFF9500)),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedSortFilter = value;
        });
      }
    });
  }

  PopupMenuItem<String> _buildSortDropdownItem(String title, IconData icon, Color color) {
    final isSelected = _selectedSortFilter == title;
    
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

  void _showContentPreview(ContentItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20), // Space for close button
                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // Content Preview
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
                    // Price
                    CoinText(
                      amount: '${item.price}',
                      textStyle: const TextStyle(
                        color: Color(0xFFFF9500),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      coinSize: 20,
                      alignment: MainAxisAlignment.center,
                    ),
                    const SizedBox(height: 20),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Show full preview
                              _showFullPreview(item);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3A3A3A),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Preview',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
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
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Close Button (X)
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
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

  void _showFullPreview(ContentItem item) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              // Full-screen preview
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFFFFA500).withOpacity(0.9),
                      const Color(0xFFFF8C00).withOpacity(0.7),
                      const Color(0xFFDAA520).withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.type == 'video')
                        const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 80,
                        ),
                      const SizedBox(height: 16),
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      CoinText(
                        amount: '${item.price}',
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        coinSize: 16,
                        alignment: MainAxisAlignment.center,
                      ),
                    ],
                  ),
                ),
              ),
              // Close Button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
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
              _buildOptionItem(Icons.share, 'Share', () {
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
  final String title;

  ContentItem({
    required this.id,
    required this.type,
    required this.thumbnail,
    required this.price,
    required this.title,
  });
}
