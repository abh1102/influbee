import 'package:flutter/material.dart';

class SetPinPage extends StatefulWidget {
  const SetPinPage({super.key});

  @override
  State<SetPinPage> createState() => _SetPinPageState();
}

class _SetPinPageState extends State<SetPinPage> {
  String _pin = '';
  final int _pinLength = 4;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Auto-focus when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onPinChanged(String value) {
    // Only allow digits and limit to PIN length
    String filteredValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (filteredValue.length > _pinLength) {
      filteredValue = filteredValue.substring(0, _pinLength);
    }
    
    setState(() {
      _pin = filteredValue;
      _pinController.value = TextEditingValue(
        text: filteredValue,
        selection: TextSelection.collapsed(offset: filteredValue.length),
      );
    });
    
    // Auto navigate when PIN is complete
    if (filteredValue.length == _pinLength) {
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushNamed(context, '/confirm_pin', arguments: filteredValue);
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              
              // Title
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
                'Create a 4-digit PIN to secure your account.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 80),
              
              // PIN Display Circles (same as Confirm PIN)
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
              
              // Instructions for native keyboard
              const Text(
                'Tap to enter your PIN',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
              
              // Invisible TextField for native keyboard input
              Opacity(
                opacity: 0.01, // Nearly invisible but still receives taps
                child: Container(
                  width: 200,
                  height: 50,
                  child: TextField(
                    controller: _pinController,
                    focusNode: _focusNode,
                    onChanged: _onPinChanged,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.transparent,
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    maxLength: _pinLength,
                    buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
                    autofocus: true,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }


}