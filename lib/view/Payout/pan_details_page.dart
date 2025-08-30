import 'package:flutter/material.dart';

import 'bank_details_page.dart';

class PanDetailsPage extends StatefulWidget {
  const PanDetailsPage({super.key});

  @override
  State<PanDetailsPage> createState() => _PanDetailsPageState();
}

class _PanDetailsPageState extends State<PanDetailsPage> {
  final _panController = TextEditingController();
  bool _panCardUploaded = false;

  @override
  void dispose() {
    _panController.dispose();
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
          'Payout Setup',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress Indicator
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStepIndicator(1, "Aadhar", true, const Color(0xFFFF9500)),
                _buildStepConnector(),
                _buildStepIndicator(2, "PAN", true, const Color(0xFFFF9500)),
                _buildStepConnector(),
                _buildStepIndicator(3, "Bank Details", false, Colors.grey),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  
                  // PAN Number Input
                  const Text(
                    'PAN Number',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _panController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your PAN number',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: const Color(0xFF2A2A2A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    textCapitalization: TextCapitalization.characters,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Upload PAN Card Section
                  _buildUploadSection(),
                  
                  const SizedBox(height: 16),
                  
                  // Upload Instructions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Instructions:',
                          style: TextStyle(
                            color: Color(0xFFFF9500),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tap to upload a clear image of your PAN card',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '• Make sure all text is clearly visible',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '• Avoid shadows and glare',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '• File size should be less than 5MB',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          
          // Continue Button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BankDetailsPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9500),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Continue',
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
  }

  Widget _buildStepIndicator(int step, String label, bool isActive, Color color) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent,
            border: Border.all(color: color, width: 2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector() {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 20),
        color: Colors.grey,
      ),
    );
  }

  Widget _buildUploadSection() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _panCardUploaded = true;
        });
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _panCardUploaded ? const Color(0xFFFF9500) : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _panCardUploaded ? Icons.check_circle : Icons.cloud_upload_outlined,
              color: _panCardUploaded ? const Color(0xFFFF9500) : Colors.grey,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              _panCardUploaded ? 'PAN Card Uploaded' : 'Upload PAN Card Image',
              style: TextStyle(
                color: _panCardUploaded ? const Color(0xFFFF9500) : Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (!_panCardUploaded) ...[
              const SizedBox(height: 8),
              const Text(
                'Tap to upload a clear image of your PAN card',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
