import 'package:flutter/material.dart';

class ConfirmPinPage extends StatefulWidget {
  const ConfirmPinPage({super.key});

  @override
  State<ConfirmPinPage> createState() => _ConfirmPinPageState();
}

class _ConfirmPinPageState extends State<ConfirmPinPage> {
  String _pin = '';
  String? _originalPin;
  final int _pinLength = 4;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the original PIN from navigation arguments
    _originalPin = ModalRoute.of(context)?.settings.arguments as String?;
  }

  void _addDigit(String digit) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += digit;
      });
      
      // Check PIN when complete
      if (_pin.length == _pinLength) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (_pin == _originalPin) {
            // PIN matches - show success
            _showSuccessDialog();
          } else {
            // PIN doesn't match - show error and reset
            _showErrorDialog();
          }
        });
      }
    }
  }

  void _removeDigit() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                color: Color(0xFFFF9500),
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'PIN Confirmed!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your PIN has been successfully set.',
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
                    Navigator.pushReplacementNamed(context, '/enter_pin');
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

  void _showErrorDialog() {
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
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                'PIN Mismatch',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'The PINs you entered do not match. Please try again.',
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
                    setState(() {
                      _pin = '';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9500),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Try Again',
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // Title
            const Text(
              'Confirm PIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Re-enter your 4-digit PIN to continue.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 80),
            
            // PIN Display Circles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index < _pin.length 
                        ? Colors.white 
                        : Colors.grey.withOpacity(0.3),
                  ),
                );
              }),
            ),
            
            const Spacer(),
            
            // Small Number Display (like in the screenshot)
            _buildSmallNumberDisplay(),
            
            const SizedBox(height: 30),
            
            // Backspace Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _removeDigit,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF2A2A2A),
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallNumberDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Row 1: 1, 2, 3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSmallNumberButton('1'),
              _buildSmallNumberButton('2'),
              _buildSmallNumberButton('3'),
            ],
          ),
          const SizedBox(height: 12),
          
          // Row 2: 4, 5, 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSmallNumberButton('4'),
              _buildSmallNumberButton('5'),
              _buildSmallNumberButton('6'),
            ],
          ),
          const SizedBox(height: 12),
          
          // Row 3: 7, 8, 9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSmallNumberButton('7'),
              _buildSmallNumberButton('8'),
              _buildSmallNumberButton('9'),
            ],
          ),
          const SizedBox(height: 12),
          
          // Row 4: 0
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSmallNumberButton('0'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallNumberButton(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
