import 'package:flutter/material.dart';
import 'package:influbee/Profile/profile_picture_upload_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController(text: 'Jessica Bee');
  final TextEditingController _handleController = TextEditingController(text: 'jessicabee');
  final TextEditingController _emailController = TextEditingController(text: 'jessica.bee@influbee.com');
  final TextEditingController _urlController = TextEditingController(text: '@jessicabee_official');
  final TextEditingController _bioController = TextEditingController(
    text: 'Spreading positivity & honey vibes ✨\nLet\'s create something sweet together! 🍯'
  );

  final Map<String, TextEditingController> _serviceControllers = {
    'Text Message': TextEditingController(text: '10'),
    'Audio Call': TextEditingController(text: '25'),
    'Video Call': TextEditingController(text: '50'),
    'AI Bot': TextEditingController(text: '5'),
    'Attachment From User': TextEditingController(),
  };

  final TextEditingController _premiumDurationController = TextEditingController();
  final TextEditingController _premiumPriceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _handleController.dispose();
    _emailController.dispose();
    _urlController.dispose();
    _bioController.dispose();
    _serviceControllers.values.forEach((controller) => controller.dispose());
    _premiumDurationController.dispose();
    _premiumPriceController.dispose();
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
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Header
            _buildProfileHeader(),
            
            const SizedBox(height: 24),
            
            // Basic Info with transparent design
            _buildBasicInfo(),
            
            const SizedBox(height: 24),
            
            // Bio Section with transparent design
            _buildBioSection(),
            
            const SizedBox(height: 24),
            
            // Services Section with transparent design
            _buildServicesSection(),
            
            const SizedBox(height: 24),
            
            // Premium Calls Section with transparent design
            _buildPremiumCallsSection(),
            
            const SizedBox(height: 24),
            
            // Save Button
            _buildSaveButton(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFF8B5CF6),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'JB',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePictureUploadPage()));
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFFFF9500),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputField('Name', _nameController),
          const SizedBox(height: 16),
          _buildInputField('Handle', _handleController, prefix: '@'),
          const SizedBox(height: 16),
          _buildInputField('Email', _emailController, verified: true),
          const SizedBox(height: 16),
          _buildInputField('Social URL/Handle', _urlController, verified: true),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {String? prefix, bool verified = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            if (prefix != null) ...[
              Text(
                prefix,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            if (verified)
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 12,
                ),
              ),
          ],
        ),
        Container(
          height: 1,
          color: Colors.white.withOpacity(0.1),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bio/Intro',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _bioController,
            style: const TextStyle(color: Colors.white),
            maxLines: 3,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Services',
            style: TextStyle(
              color: Color(0xFFFF9500),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          ..._serviceControllers.entries.map((entry) => 
            _buildServiceItem(entry.key, entry.value)
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String serviceName, TextEditingController controller) {
    IconData icon;
    Color iconColor;
    
    switch (serviceName) {
      case 'Text Message':
        icon = Icons.message;
        iconColor = const Color(0xFF8B5CF6);
        break;
      case 'Audio Call':
        icon = Icons.headset_mic;
        iconColor = const Color(0xFF06B6D4);
        break;
      case 'Video Call':
        icon = Icons.videocam;
        iconColor = const Color(0xFF10B981);
        break;
      case 'AI Bot':
        icon = Icons.smart_toy;
        iconColor = const Color(0xFFF59E0B);
        break;
      default:
        icon = Icons.attach_file;
        iconColor = const Color(0xFF6B7280);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A).withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              serviceName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            '\$',
            style: TextStyle(
              color: Color(0xFFFF9500),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 50,
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCallsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.diamond,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Premium Calls',
                style: TextStyle(
                  color: Color(0xFFFF9500),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.add,  // Changed from star to +
                color: Color(0xFFFF9500),
                size: 16,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPremiumField('Heading', 'e.g. 1-on-1 Coaching'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildPremiumField('Duration', 'min', controller: _premiumDurationController),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildPremiumField('Price', '\$', controller: _premiumPriceController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumField(String label, String placeholder, {TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A).withOpacity(0.8),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
              backgroundColor: Color(0xFFFF9500),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF9500),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Save Changes',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}