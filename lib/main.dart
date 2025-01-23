import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'constants.dart';
import 'home_screen.dart';
import 'preference/user_reference.dart';
import 'splash_screen.dart';
import 'theme/app_text_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(initialLanguage: await UserReference().getLanguage() ?? 'en'));
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

  void _changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textTheme: AppTextTheme.textTheme,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        ScreenName.home: (context) => HomeScreen(changeLanguage: _changeLanguage),
      },
    );
  }
}
