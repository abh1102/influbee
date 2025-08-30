import 'package:flutter/material.dart';

class EnterPinPage extends StatefulWidget {
  const EnterPinPage({super.key});

  @override
  State<EnterPinPage> createState() => _EnterPinPageState();
}

class _EnterPinPageState extends State<EnterPinPage> {
  String _pin = '';
  final int _pinLength = 4;

  void _addDigit(String digit) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += digit;
      });
      
      // Auto navigate when PIN is complete
      if (_pin.length == _pinLength) {
        Future.delayed(const Duration(milliseconds: 300), () {
          // Simulate PIN verification (in real app, verify against stored PIN)
          Navigator.pushReplacementNamed(context, '/');
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
            const SizedBox(height: 20),
            
            // Influbee Logo and Title
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9500),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.security,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Influbee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Title and Subtitle
            const Text(
              'Enter your PIN',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your 4-digit PIN to access your account',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 60),
            
            // PIN Display Circles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pinLength, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 16,
                  height: 16,
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
            
            // Number Keypad
            _buildKeypad(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad() {
    return Column(
      children: [
        // Row 1: 1, 2, 3
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('1'),
            _buildKeypadButton('2'),
            _buildKeypadButton('3'),
          ],
        ),
        const SizedBox(height: 20),
        
        // Row 2: 4, 5, 6
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('4'),
            _buildKeypadButton('5'),
            _buildKeypadButton('6'),
          ],
        ),
        const SizedBox(height: 20),
        
        // Row 3: 7, 8, 9
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildKeypadButton('7'),
            _buildKeypadButton('8'),
            _buildKeypadButton('9'),
          ],
        ),
        const SizedBox(height: 20),
        
        // Row 4: Empty, 0, Backspace
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 70, height: 70), // Empty space
            _buildKeypadButton('0'),
            _buildBackspaceButton(),
          ],
        ),
      ],
    );
  }

  Widget _buildKeypadButton(String digit) {
    return GestureDetector(
      onTap: () => _addDigit(digit),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF2A2A2A),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            digit,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    return GestureDetector(
      onTap: _removeDigit,
      child: Container(
        width: 70,
        height: 70,
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
            size: 24,
          ),
        ),
      ),
    );
  }
}
