import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';

class SetupRatesPage extends StatefulWidget {
  const SetupRatesPage({super.key});

  @override
  State<SetupRatesPage> createState() => _SetupRatesPageState();
}

class _SetupRatesPageState extends State<SetupRatesPage> {
  final Map<String, TextEditingController> _serviceControllers = {
    'Text Message': TextEditingController(text: '10'),
    'Audio Call': TextEditingController(text: '25'),
    'Video Call': TextEditingController(text: '50'),
    'AI Bot': TextEditingController(text: '5'),
    'Attachment From User': TextEditingController(),
  };



  @override
  void dispose() {
    _serviceControllers.values.forEach((controller) => controller.dispose());
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
          'Setup Rates',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Services Section
            _buildServicesSection(),
            
            const SizedBox(height: 24),
            
            // Premium Calls Section
            _buildPremiumCallsSection(),
            
            const SizedBox(height: 32),
            
            // Save Changes Button
            _buildSaveButton(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }



  Widget _buildServicesSection() {
    return Column(
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
          _buildServiceBox(entry.key, entry.value)
        ),
      ],
    );
  }

  Widget _buildServiceBox(String serviceName, TextEditingController controller) {
    IconData icon;
    
    switch (serviceName) {
      case 'Text Message':
        icon = Icons.chat_bubble_outline;
        break;
      case 'Audio Call':
        icon = Icons.headset_mic;
        break;
      case 'Video Call':
        icon = Icons.videocam;
        break;
      case 'AI Bot':
        icon = Icons.smart_toy;
        break;
      default:
        icon = Icons.attach_file;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A).withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              serviceName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 80,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const InflubeeCoin(size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      isDense: true,
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

  Widget _buildPremiumCallsSection() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/premium_calls');
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A).withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.workspace_premium,
                color: Color(0xFFFF9500),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Calls',
                    style: TextStyle(
                      color: Color(0xFFFF9500),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Manage your premium call offerings',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Save rates logic here
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rates saved successfully!'),
              backgroundColor: Color(0xFFFF9500),
            ),
          );
          // Redirect to dashboard
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (route) => false,
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
