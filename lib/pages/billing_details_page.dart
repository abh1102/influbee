import 'package:flutter/material.dart';
import '../utils/notification_helper.dart';

class BillingDetailsPage extends StatefulWidget {
  const BillingDetailsPage({super.key});

  @override
  State<BillingDetailsPage> createState() => _BillingDetailsPageState();
}

class _BillingDetailsPageState extends State<BillingDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _billingNameController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _gstinController = TextEditingController();
  final TextEditingController _gstNameController = TextEditingController();

  @override
  void dispose() {
    _billingNameController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    _gstinController.dispose();
    _gstNameController.dispose();
    super.dispose();
  }

  void _saveBillingDetails() {
    if (_formKey.currentState!.validate()) {
      // Show success dialog
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
                  Icons.check_circle_outline,
                  color: Color(0xFF4CAF50),
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Billing Details Saved!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your billing information has been saved successfully.',
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
                      Navigator.of(context).pop(); // Close dialog
                      // Show success notification
                      NotificationHelper.showSuccessNotification(context, 'Billing details saved successfully!');
                      // Navigate back to settings but keep the dashboard in the stack
                      Navigator.popUntil(context, (route) => 
                        route.settings.name == '/settings' || 
                        route.settings.name == '/dashboard'
                      );
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
          'Billing Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                
                // Billing Name
                _buildInputField(
                  'Billing Name',
                  _billingNameController,
                  'Enter full name for billing',
                  required: true,
                ),
                
                const SizedBox(height: 20),
                
                // Address Line 1
                _buildInputField(
                  'Address Line 1',
                  _addressLine1Controller,
                  'House/Building number, Street name',
                  required: true,
                ),
                
                const SizedBox(height: 20),
                
                // Address Line 2
                _buildInputField(
                  'Address Line 2',
                  _addressLine2Controller,
                  'Area, Landmark (Optional)',
                  required: false,
                ),
                
                const SizedBox(height: 20),
                
                // City and State Row
                Row(
                  children: [
                    Expanded(
                      child: _buildInputField(
                        'City',
                        _cityController,
                        'Enter city',
                        required: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildInputField(
                        'State',
                        _stateController,
                        'Enter state',
                        required: true,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // ZIP Code
                _buildInputField(
                  'ZIP/Postal Code',
                  _zipController,
                  'Enter ZIP code',
                  required: true,
                  keyboardType: TextInputType.number,
                ),
                
                const SizedBox(height: 32),
                
                // GST Section Header
                const Text(
                  'GST Information (Optional)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // GSTIN Number
                _buildInputField(
                  'GSTIN Number',
                  _gstinController,
                  'Enter GSTIN (15 digits)',
                  required: false,
                  maxLength: 15,
                ),
                
                const SizedBox(height: 20),
                
                // GST Name
                _buildInputField(
                  'GST Registered Name',
                  _gstNameController,
                  'Enter GST registered business name',
                  required: false,
                ),
                
                const SizedBox(height: 40),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveBillingDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9500),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint, {
    bool required = false,
    TextInputType keyboardType = TextInputType.text,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (required)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFFF9500).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLength: maxLength,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              counterText: '', // Hide character counter
            ),
            validator: (value) {
              if (required && (value == null || value.trim().isEmpty)) {
                return 'This field is required';
              }
              
              // Specific validations
              if (label == 'ZIP/Postal Code' && value != null && value.isNotEmpty) {
                if (value.length != 6) {
                  return 'ZIP code must be 6 digits';
                }
              }
              
              if (label == 'GSTIN Number' && value != null && value.isNotEmpty) {
                if (value.length != 15) {
                  return 'GSTIN must be 15 characters';
                }
              }
              
              return null;
            },
          ),
        ),
      ],
    );
  }
}
