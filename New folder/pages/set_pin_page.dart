import 'package:flutter/material.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage({super.key});

  @override
  State<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
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
          Navigator.pushNamed(context, '/confirm_pin', arguments: _pin);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Shield Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF9500),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Title and Subtitle
              const Text(
                'Set Your PIN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Secure your account with a 4-digit PIN',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // PIN Input Squares
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(_pinLength, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: index < _pin.length 
                            ? const Color(0xFFFF9500) 
                            : Colors.grey.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        index < _pin.length ? _pin[index] : '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                                      );
                  }),
                ),
              ),
              
              const Spacer(),
              
              // Number Keypad
              _buildKeypad(),
              
              const SizedBox(height: 40),
            ],
          ),
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