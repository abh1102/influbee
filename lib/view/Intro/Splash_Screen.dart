import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 8), () {
       Get.offAllNamed(AppRoutes.LOGIN);
      // Get.offAllNamed(AppRoutes.NEWPOST);
    });
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D102D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _glowAnimation.value,
                  child: Image.asset(
                    'assets/Images/logo.jpeg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
            // const FadeInText(),
          ],
        ),
      ),
    );
  }
}


//
// class FadeInText extends StatefulWidget {
//   const FadeInText({super.key});
//
//   @override
//   State<FadeInText> createState() => _FadeInTextState();
// }
//
// class _FadeInTextState extends State<FadeInText> with TickerProviderStateMixin {
//   late AnimationController _textFadeController;
//
//   @override
//   void initState() {
//     super.initState();
//     _textFadeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..forward();
//   }
//
//   @override
//   void dispose() {
//     _textFadeController.dispose();
//     super.dispose();
//   }

  // @override
  // Widget build(BuildContext context) {
  //   return FadeTransition(
  //     opacity: _textFadeController,
  //     child: const Text(
  //       'Influbee',
  //       style: TextStyle(
  //         color: Colors.white,
  //         fontSize: 32,
  //         fontWeight: FontWeight.bold,
  //         letterSpacing: 1.2,
  //       ),
  //     ),
  //   );
  // }

