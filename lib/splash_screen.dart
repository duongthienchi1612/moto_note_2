import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'business/master_data_business.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'preference/user_reference.dart';
import 'utilities/app_configuration.dart';
import 'utilities/database_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String statusQuiz;
  late String houseResult;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _requestPermissions() async {
    bool isAllGranted = true;
    if (Platform.isAndroid) {
      if (!(await Permission.manageExternalStorage.isGranted)) {
        final permission = await Permission.manageExternalStorage.request();
        isAllGranted = permission == PermissionStatus.granted;
      }
    }
    return isAllGranted;
  }

  Future<void> _initializeDependencies() async {
    await AppDependencies.initialize();
    final isAllGranted = await _requestPermissions();
    if (isAllGranted) {

      final appConfig = injector.get<AppConfiguration>();
      await appConfig.init();

      final databaseFactory = injector.get<DatabaseFactory>();
      await databaseFactory.initDatabase();

      final masterData = injector.get<MasterDataBusiness>();
      await masterData.init();

    } else {
      await openAppSettings();
      exit(0);
    }
  }

  Future<void> timeSplashScreen() async {
    await Future.wait(
      [_initializeDependencies(), Future.delayed(const Duration(seconds: 1))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: timeSplashScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.splash_screen),
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, ScreenName.home);
            });
            return Container();
          }
        });
  }
}
