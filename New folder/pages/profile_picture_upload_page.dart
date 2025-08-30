import 'package:flutter/material.dart';

class ProfilePictureUploadPage extends StatefulWidget {
  const ProfilePictureUploadPage({super.key});

  @override
  State<ProfilePictureUploadPage> createState() => _ProfilePictureUploadPageState();
}

class _ProfilePictureUploadPageState extends State<ProfilePictureUploadPage> {
  bool _hasSelectedImage = false;
  String _selectedImageType = '';

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
          'Profile Picture',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // Current Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: _hasSelectedImage 
                          ? const Color(0xFF8B5CF6) 
                          : const Color(0xFF2A2A2A),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 3,
                      ),
                    ),
                    child: _hasSelectedImage
                        ? const Center(
                            child: Text(
                              'JD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                            size: 60,
                          ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _showImageOptions,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF9500),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text(
              'Add Profile Picture',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Choose a photo that represents you. This will be visible to other users.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 48),
            
            // Upload Options
            _buildUploadOption(
              Icons.photo_library,
              'Choose from Gallery',
              'Select from your existing photos',
              () => _selectImage('gallery'),
            ),
            
            const SizedBox(height: 16),
            
            _buildUploadOption(
              Icons.camera_alt,
              'Take Photo',
              'Capture a new photo with your camera',
              () => _selectImage('camera'),
            ),
            
            const SizedBox(height: 16),
            
            _buildUploadOption(
              Icons.person,
              'Choose Avatar',
              'Select from pre-designed avatars',
              () => _selectImage('avatar'),
            ),
            
            if (_hasSelectedImage) ...[
              const SizedBox(height: 48),
              
              // Image Options
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
                      'Image Options',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildImageOption('Crop & Resize', Icons.crop),
                    const SizedBox(height: 12),
                    _buildImageOption('Apply Filter', Icons.filter),
                    const SizedBox(height: 12),
                    _buildImageOption('Adjust Brightness', Icons.brightness_6),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 48),
            
            // Action Buttons
            Row(
              children: [
                if (_hasSelectedImage) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _removeImage,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasSelectedImage ? _saveProfilePicture : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _hasSelectedImage 
                          ? const Color(0xFFFF9500) 
                          : const Color(0xFF3A3A3A),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _hasSelectedImage ? 'Save Picture' : 'Select Image First',
                      style: TextStyle(
                        color: _hasSelectedImage ? Colors.white : Colors.grey,
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
      ),
    );
  }

  Widget _buildUploadOption(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFFF9500),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
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
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageOption(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title feature coming soon!'),
            backgroundColor: const Color(0xFFFF9500),
          ),
        );
      },
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFFFF9500),
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.chevron_right,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  void _showImageOptions() {
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
                'Profile Picture Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _buildOptionItem(Icons.photo_library, 'Choose from Gallery', () => _selectImage('gallery')),
              _buildOptionItem(Icons.camera_alt, 'Take Photo', () => _selectImage('camera')),
              _buildOptionItem(Icons.person, 'Choose Avatar', () => _selectImage('avatar')),
              if (_hasSelectedImage)
                _buildOptionItem(Icons.delete, 'Remove Picture', _removeImage, isDestructive: true),
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
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }

  void _selectImage(String type) {
    setState(() {
      _hasSelectedImage = true;
      _selectedImageType = type;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${type.toUpperCase()} selected successfully!'),
        backgroundColor: const Color(0xFF4CAF50),
      ),
    );
  }

  void _removeImage() {
    setState(() {
      _hasSelectedImage = false;
      _selectedImageType = '';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile picture removed'),
        backgroundColor: Colors.grey,
      ),
    );
  }

  void _saveProfilePicture() {
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
              const Text(
                'Profile Picture Updated!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your profile picture has been successfully updated.',
                style: TextStyle(
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
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Done',
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
        );
      },
    );
  }
}
