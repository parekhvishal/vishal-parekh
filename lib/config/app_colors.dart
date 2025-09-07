import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color appBackground = Color(0xFF000000); // Black
  static const Color appLightBackground = Color(0xFF111111);
  static const Color goldPrimary = Color(0xFF00FF00); // Green
  static const Color goldSecondary = Color(0xFF00CC00); // Darker Green
  
  // Text Colors
  static const Color textPrimary = Color(0xFF00FF00); // Green
  static const Color textSecondary = Color(0xFFFFFFFF); // White
  static const Color textMuted = Color(0xFFB0B0B0); // Light Gray
  
  // Accent Colors
  static const Color accentGold = Color(0xFF00FF00);
  static const Color accentGoldDark = Color(0xFF00CC00);
  
  // Utility Colors
  static const Color cardBackground = Color(0XFF0f0f0f);
  static const Color hoverColor = Color(0xFF00FF00);
  static const Color shadowColor = Colors.grey;
  
  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldPrimary, goldSecondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0xFF111111),
    ],
  );
}

// App Decoration Styles
class AppDecoration {
  static BoxDecoration containerDecoration({
    Color? backgroundColor,
    double borderRadius = 20.0,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? AppColors.cardBackground,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
  
  static BoxDecoration glowDecoration({
    Color glowColor = AppColors.goldPrimary,
    double borderRadius = 20.0,
  }) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: glowColor.withValues(alpha: 0.3),
          spreadRadius: 3,
          blurRadius: 20,
          offset: const Offset(0, 0),
        ),
      ],
    );
  }
}
