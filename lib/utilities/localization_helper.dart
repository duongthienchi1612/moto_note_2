import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LocalizationHelper {
  static AppLocalizations? _localizations;

  static AppLocalizations get localizations {
    if (_localizations == null) {
      throw Exception('LocalizationHelper chưa được khởi tạo!');
    }
    return _localizations!;
  }

  static set localizations(AppLocalizations value) {
    _localizations = value;
  }

  static AppLocalizations get instance {
    if (_localizations == null) {
      throw Exception('LocalizationHelper chưa được khởi tạo!');
    }
    return _localizations!;
  }

  // Lấy ngôn ngữ hiện tại của ứng dụng
  static String getCurrentLanguageCode(BuildContext context) {
    return Localizations.localeOf(context).languageCode;
  }
}
