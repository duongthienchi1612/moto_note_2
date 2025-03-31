import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import 'business/master_data_business.dart';
import 'constants.dart';
import 'dependencies.dart';
import 'model/user_entity.dart';
import 'preference/user_reference.dart';
import 'repository/interface/users_repository.dart';
import 'utilities/app_configuration.dart';
import 'utilities/database_factory.dart';
import 'utilities/localization_helper.dart';
import 'utilities/static_var.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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

      // get reference data;
      final userRef = injector.get<UserReference>();
      if (await userRef.getCurrentKm() == null) {
        await userRef.setCurrentKm(0);
      }

      // get user id
      final userRepo = injector.get<IUserRepository>();
      final localizations = LocalizationHelper.instance;
      final currentUserId = await userRef.getCurrentUserId();
      StaticVar.currentUserId = currentUserId ?? '';
      if (StringUtils.isNullOrEmpty(currentUserId)) {
        final item = UserEntity()
          ..userName = localizations.userNameTemp
          ..id = Uuid().v4();
        await userRepo.insert(item);
        await userRef.setCurrentUserId(item.id!);
        await userRef.setCurrentUserName(item.userName!);
        StaticVar.currentUserId = item.id!;
      }
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
              color: Colors.white,
              child: SafeArea(
                child: Center(
                  child: Lottie.asset(
                    ImagePath.splash_screen,
                  ),
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
