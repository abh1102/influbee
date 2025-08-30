import 'package:flutter/material.dart';

class NewPostMediaPage extends StatefulWidget {
  const NewPostMediaPage({super.key});

  @override
  State<NewPostMediaPage> createState() => _NewPostMediaPageState();
}

class _NewPostMediaPageState extends State<NewPostMediaPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _hasUploadedMedia = false;
  String _uploadedMediaType = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          icon: const Icon(Icons.close, color: Colors.white),
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Upload Media',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Supported formats: JPG, PNG, MP4. Max size: 50MB',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Drag & Drop Area
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFF9500),
                  width: 2,
                  style: BorderStyle.solid,
                ),
              ),
              child: _hasUploadedMedia ? _buildUploadedContent() : _buildUploadPrompt(),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Preview Section
          if (_hasUploadedMedia) ...[
            const Text(
              'Preview',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
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
                child: Container(
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
                  child: _uploadedMediaType == 'video'
                      ? const Center(
                          child: Icon(
                            Icons.play_circle_outline,
                            color: Colors.white,
                            size: 60,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
          
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
                    'Cancel',
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
                  onPressed: _hasUploadedMedia ? _goToDetails : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasUploadedMedia 
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
                      color: _hasUploadedMedia ? Colors.white : Colors.grey,
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

  Widget _buildUploadPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9500).withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.folder_open,
            color: Color(0xFFFF9500),
            size: 40,
          ),
        ),
        
        const SizedBox(height: 24),
        
        const Text(
          'Drag & drop files here',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 8),
        
        const Text(
          'or',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        
        const SizedBox(height: 16),
        
        ElevatedButton(
          onPressed: _browseFiles,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF9500),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Browse Files',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadedContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.check_circle_outline,
              color: Color(0xFF4CAF50),
              size: 40,
            ),
          ),
          
          const SizedBox(height: 24),
          
          const Text(
            'Media uploaded successfully!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            _uploadedMediaType == 'video' ? 'honey_video.mp4' : 'honey_image.jpg',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 16),
          
          ElevatedButton(
            onPressed: _browseFiles,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9500),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Change File',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return const Center(
      child: Text(
        'Details Tab - Coming soon',
        style: TextStyle(color: Colors.white),
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

  void _browseFiles() {
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
              const Text(
                'Select Media Type',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildMediaOption(
                Icons.image,
                'Choose Image',
                'JPG, PNG up to 50MB',
                () => _selectMedia('image'),
              ),
              const SizedBox(height: 12),
              _buildMediaOption(
                Icons.videocam,
                'Choose Video',
                'MP4 up to 50MB',
                () => _selectMedia('video'),
              ),
              const SizedBox(height: 12),
              _buildMediaOption(
                Icons.camera_alt,
                'Take Photo',
                'Capture with camera',
                () => _selectMedia('camera'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMediaOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFFFF9500).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFFF9500),
        ),
      ),
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
      onTap: onTap,
    );
  }

  void _selectMedia(String type) {
    Navigator.of(context).pop();
    setState(() {
      _hasUploadedMedia = true;
      _uploadedMediaType = type;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${type.toUpperCase()} selected successfully!'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _goToDetails() {
    Navigator.pushNamed(
      context, 
      '/new_post_details',
      arguments: {
        'mediaType': _uploadedMediaType,
        'hasMedia': _hasUploadedMedia,
      },
    );
  }
}
