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
  List<String> _uploadedImages = []; // Store multiple images
  int _selectedImageIndex = 0; // Current viewing image in gallery

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildProgressStep('Media', 0, true),
                const SizedBox(width: 8),
                _buildProgressStep('Details', 1, false),
                const SizedBox(width: 8),
                _buildProgressStep('Price', 2, false),
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
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Upload Media',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_uploadedImages.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9500).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF9500),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${_uploadedImages.length} ${_uploadedImages.length == 1 ? 'Photo' : 'Photos'}',
                    style: const TextStyle(
                      color: Color(0xFFFF9500),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Supported formats: JPG, PNG, MP4. Max size: 50MB each. Upload multiple photos for gallery posts.',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Preview',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_uploadedImages.length > 1)
                  Text(
                    '${_selectedImageIndex + 1} of ${_uploadedImages.length}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
              ],
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
                child: Stack(
                  children: [
                    Container(
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
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    _uploadedImages.isNotEmpty 
                                        ? _uploadedImages[_selectedImageIndex]
                                        : 'honey_image.jpg',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                    // Navigation arrows for multiple images
                    if (_uploadedImages.length > 1) ...[
                      // Previous button
                      if (_selectedImageIndex > 0)
                        Positioned(
                          left: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImageIndex--;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Next button
                      if (_selectedImageIndex < _uploadedImages.length - 1)
                        Positioned(
                          right: 8,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImageIndex++;
                                });
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                    // Gallery indicator dots
                    if (_uploadedImages.length > 1)
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _uploadedImages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == _selectedImageIndex
                                    ? const Color(0xFFFF9500)
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Gallery thumbnails if multiple images
            if (_uploadedImages.length > 1) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _uploadedImages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedImageIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3A3A3A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: index == _selectedImageIndex
                                ? const Color(0xFFFF9500)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color(0xFFFFA500).withOpacity(0.6),
                                      const Color(0xFFFF8C00).withOpacity(0.4),
                                    ],
                                  ),
                                ),
                              ),
                              const Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              // Delete button
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () => _removeImage(index),
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
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
          
          Text(
            _uploadedImages.length > 1 
              ? '${_uploadedImages.length} photos uploaded successfully!'
              : 'Media uploaded successfully!',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 8),
          
          Text(
            _uploadedMediaType == 'video' 
              ? 'honey_video.mp4' 
              : _uploadedImages.length > 1
                ? 'Gallery with ${_uploadedImages.length} photos'
                : 'honey_image.jpg',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _browseFiles,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9500),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _uploadedImages.length > 1 ? 'Add More Photos' : 'Change File',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (_uploadedImages.length > 1) ...[
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _uploadedImages.clear();
                      _hasUploadedMedia = false;
                      _uploadedMediaType = '';
                      _selectedImageIndex = 0;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.grey.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Complete Media Upload First',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Upload your media and click Next to continue',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.monetization_on_outlined,
            color: Colors.grey.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Complete Previous Steps First',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete media upload and details to set pricing',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.preview_outlined,
            color: Colors.grey.withOpacity(0.5),
            size: 48,
          ),
          const SizedBox(height: 16),
          const Text(
            'Complete All Steps First',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete all previous steps to review your post',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
                'Choose Single Image',
                'JPG, PNG up to 50MB',
                () => _selectMedia('image'),
              ),
              const SizedBox(height: 12),
              _buildMediaOption(
                Icons.photo_library,
                'Choose Multiple Images',
                'Create a photo gallery (2-12 photos)',
                () => _selectMedia('gallery'),
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

  Widget _buildMediaOption(IconData icon, String title, String subtitle, VoidCallback onTap, {bool isHighlighted = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFFFF9500).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: isHighlighted ? Border.all(color: const Color(0xFFFF9500).withOpacity(0.3)) : null,
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFFF9500).withOpacity(isHighlighted ? 0.3 : 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFFFF9500),
          ),
        ),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isHighlighted) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: onTap,
      ),
    );
  }

  void _selectMedia(String type) {
    Navigator.of(context).pop();
    
    if (type == 'gallery') {
      // Simulate selecting multiple images (in real app, would use file picker)
      final List<String> newImages = [
        'photo_1.jpg',
        'photo_2.jpg', 
        'photo_3.jpg',
      ];
      
      setState(() {
        _uploadedImages.addAll(newImages);
        _hasUploadedMedia = true;
        _uploadedMediaType = 'image';
        _selectedImageIndex = _uploadedImages.length - newImages.length; // Show first new image
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newImages.length} photos selected successfully!'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } else if (type == 'image' || type == 'camera') {
      // Add single image
      final String newImage = type == 'camera' ? 'camera_photo.jpg' : 'selected_image.jpg';
      
      setState(() {
        if (_uploadedMediaType != 'image') {
          // First image or switching from video
          _uploadedImages.clear();
        }
        _uploadedImages.add(newImage);
        _hasUploadedMedia = true;
        _uploadedMediaType = 'image';
        _selectedImageIndex = _uploadedImages.length - 1; // Show the new image
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${type.toUpperCase()} selected successfully!'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    } else {
      // Video selection
      setState(() {
        _uploadedImages.clear(); // Clear images when selecting video
        _hasUploadedMedia = true;
        _uploadedMediaType = type;
        _selectedImageIndex = 0;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${type.toUpperCase()} selected successfully!'),
          backgroundColor: const Color(0xFF4CAF50),
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
      
      if (_uploadedImages.isEmpty) {
        _hasUploadedMedia = false;
        _uploadedMediaType = '';
        _selectedImageIndex = 0;
      } else {
        // Adjust selected index if needed
        if (_selectedImageIndex >= _uploadedImages.length) {
          _selectedImageIndex = _uploadedImages.length - 1;
        }
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Photo removed'),
        backgroundColor: Color(0xFFFF9500),
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

  void _goToDetails() {
    Navigator.pushNamed(
      context, 
      '/new_post_details',
      arguments: {
        'mediaType': _uploadedMediaType,
        'hasMedia': _hasUploadedMedia,
        'uploadedImages': _uploadedImages,
        'isGallery': _uploadedImages.length > 1,
      },
    );
  }
}
