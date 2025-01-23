import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../dependencies.dart';
import 'database_manager.dart';
import 'file_utility.dart';

class DatabaseFactory {
  final FileUtility fileUtility = injector.get<FileUtility>();

  Future initDatabase() async {
    await initLocalDatabase();
    await getMasterData();
  }

  Future<String> initLocalDatabase() async {
    final folderPath = await fileUtility.getCommonDatabaseFolder();
    final dbPath = join(folderPath, 'master_data.db');
    log(dbPath);

    final bool isExist = await File(dbPath).exists();
    if (!isExist) {
      await File(dbPath).create(recursive: true);
    }
    // copy database from asset to local
    final bytes = await rootBundle.load('assets/database/master_data.db');
    await File(dbPath).writeAsBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return dbPath;
  }

  Future<DatabaseManager> getMasterData() async {
    final folderPath = await fileUtility.getCommonDatabaseFolder();
    final filePath = join(folderPath, 'master_data.db');
    final db = DatabaseManager(path: filePath);
    await db.open();
    return db;
  }
}
