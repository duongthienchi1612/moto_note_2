import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static const statusRed = Color(0xFFFF3B30);
  static const statusYellow = Color(0xFFFFCC00);
  static const statusGreen = Color(0xFF34C759);
  static const waveColorBold = Color(0xFFDADEF8);
  static const waveColorMedium = Color(0xFFE0E3F4);
  static const waveColorSoft = Color(0xFFEDF0FB);
  static const buyMeACoffeColor = Color(0xFFF8D700);
  static const menuBackgroundColor = Color(0xFF162039);

  static const Map<int, Color> devicesType = {
    1: Color(0xFFD32F2F), // Hệ thống động cơ
    2: Color(0xFF1976D2), // Hệ thống điện & Ắc quy
    3: Color(0xFFFF9800), // Hệ thống bôi trơn
    4: Color(0xFF4CAF50), // Hệ thống lốp & bánh xe
    5: Color(0xFF9C27B0), // Hệ thống truyền động
    6: Color(0xFF009688), // Hệ thống phanh
    7: Color(0xFFFFEB3B), // Hệ thống chiếu sáng
  };
  static const Map<int, Color> devicesTypeTextButton = {
    1: Colors.white,
    2: Colors.white,
    3: Colors.white,
    4: Colors.white,
    5: Colors.white,
    6: Colors.white,
    7: Colors.black,
  };
}
