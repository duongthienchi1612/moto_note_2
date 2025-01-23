import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextTheme {
  AppTextTheme._();
  static TextTheme textTheme = TextTheme(
    // Tiêu đề chính
    displayLarge: TextStyle(
      fontSize: 32,
      fontFamily: 'Caudex',
      color: AppColors.textMainColor,
    ),
    // Tiêu đề phụ
    displayMedium: TextStyle(
      fontSize: 28,
      fontFamily: 'Caudex',
      color: AppColors.textMainColor,
      fontWeight: FontWeight.bold,
    ),
    // Văn bản chính
    bodyLarge: TextStyle(
      fontSize: 22,
      fontFamily: 'Caudex',
      color: AppColors.textMainColor,
    ),
    // Văn bản phụ
    bodyMedium: TextStyle(
      fontSize: 16,
      fontFamily: 'Caudex',
      //  fontWeight: FontWeight.bold,
    ),
    // Chú thích
    bodySmall: TextStyle(
      fontSize: 14,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    // Định nghĩa cho nút hoặc văn bản hành động
    labelLarge: TextStyle(
      fontSize: 18,
      fontFamily: 'Caudex',
      fontWeight: FontWeight.bold,
      color: AppColors.textMainColor,
    ),
  );
}
