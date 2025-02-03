import 'package:flutter/material.dart';

import '../constants.dart';
import '../theme/app_colors.dart';

class ColorsUtility {
  ColorsUtility._();

  static Color getStatusColor(int? nextReplacement, int currentKm) {
    if (nextReplacement == null) {
      return Colors.grey;
    }
    final status = nextReplacement - currentKm;
    if (status < 0) {
      return AppColors.statusRed;
    } else if (status < Constants.archorKm) {
      return AppColors.statusYellow;
    } else {
      return AppColors.statusGreen;
    }
  }
}
