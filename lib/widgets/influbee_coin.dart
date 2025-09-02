import 'package:flutter/material.dart';

class InflubeeCoin extends StatelessWidget {
  final double size;
  final Color? color;
  
  const InflubeeCoin({
    super.key,
    this.size = 16,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9500).withOpacity(0.3),
            blurRadius: size * 0.1,
            spreadRadius: size * 0.02,
            offset: Offset(0, size * 0.05),
          ),
        ],
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFD700), // Bright Gold
              const Color(0xFFFF9500), // Orange
              const Color(0xFFFF8C00), // Dark Orange
              const Color(0xFFD4AF37), // Metallic Gold
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
          border: Border.all(
            color: const Color(0xFFFFD700).withOpacity(0.8),
            width: size * 0.08,
          ),
        ),
        child: Stack(
          children: [
            // Inner ring for premium look
            Center(
              child: Container(
                width: size * 0.85,
                height: size * 0.85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFF8DC).withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Premium bee design
            Center(
              child: Container(
                width: size * 0.6,
                height: size * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFD700),
                      const Color(0xFFFF9500),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    '🐝',
                    style: TextStyle(
                      fontSize: size * 0.4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: size * 0.02,
                          offset: Offset(size * 0.01, size * 0.01),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Text elements (simplified for small sizes)
            if (size > 30) ...[
              // Top text: INFLUBEE
              Positioned(
                top: size * 0.15,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'INFLUBEE',
                    style: TextStyle(
                      fontSize: size * 0.08,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF8B4513),
                      letterSpacing: size * 0.005,
                    ),
                  ),
                ),
              ),
              // Bottom text: 2025
              Positioned(
                bottom: size * 0.15,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    '2025',
                    style: TextStyle(
                      fontSize: size * 0.08,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF8B4513),
                      letterSpacing: size * 0.005,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CoinText extends StatelessWidget {
  final String amount;
  final TextStyle? textStyle;
  final double coinSize;
  final MainAxisAlignment alignment;
  
  const CoinText({
    super.key,
    required this.amount,
    this.textStyle,
    this.coinSize = 16,
    this.alignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        InflubeeCoin(size: coinSize),
        SizedBox(width: coinSize * 0.3),
        Text(
          amount,
          style: textStyle,
        ),
      ],
    );
  }
}

// Helper function to easily create coin text
Widget coinText(String amount, {TextStyle? style, double coinSize = 16}) {
  return CoinText(
    amount: amount,
    textStyle: style,
    coinSize: coinSize,
  );
}
