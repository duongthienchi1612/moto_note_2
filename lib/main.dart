import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'home_screen.dart';
import 'splash_screen.dart';
import 'theme/app_text_theme.dart';
import 'utilities/localization_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Đọc ngôn ngữ từ SharedPreferences trực tiếp
  final prefs = await SharedPreferences.getInstance();
  final currentUserId = prefs.getString(PreferenceKey.currentUserId);
  final languageKey = '${currentUserId}_${PreferenceKey.language}';
  final initialLanguage = prefs.getString(languageKey) ?? 'vi';
  
  runApp(MyApp(initialLanguage: initialLanguage));
}

class MyApp extends StatefulWidget {
  final String initialLanguage;
  const MyApp({super.key, required this.initialLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.initialLanguage);
  }

  Future<void> _changeLanguage(String languageCode) async {
    setState(() {
      _locale = Locale(languageCode);
    });
    
    // Lưu ngôn ngữ mới vào SharedPreferences trực tiếp
    final prefs = await SharedPreferences.getInstance();
    final currentUserId = prefs.getString(PreferenceKey.currentUserId);
    final languageKey = '${currentUserId}_${PreferenceKey.language}';
    await prefs.setString(languageKey, languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textTheme: AppTextTheme.textTheme,
      ),
      builder: (context, child) {
        // Khởi tạo LocalizationHelper khi AppLocalizations đã sẵn sàng
        final localizations = AppLocalizations.of(context);
        if (localizations != null) {
          LocalizationHelper.localizations = localizations;
        }
        return child!;
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        ScreenName.home: (context) => HomeScreen(changeLanguage: _changeLanguage),
      },
    );
  }
}
