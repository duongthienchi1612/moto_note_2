import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme textTheme = TextTheme(
    // Tiêu đề lớn
    displayLarge: TextStyle(
      fontSize: 32,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
    ),
    // Tiêu đề trung bình
    headlineMedium: TextStyle(
      fontSize: 24,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.w600,
    ),    
    headlineSmall: TextStyle(
      fontSize: 20,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.w600,
    ),
    // Văn bản chính
    titleLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w600,
    ),
    // Văn bản chính
    bodyLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Inter',
    ),
    // Văn bản phụ
    bodyMedium: TextStyle(
      fontSize: 14,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.bold,
    )
  );
}
