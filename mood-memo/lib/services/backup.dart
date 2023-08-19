import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> backupHiveBox<T>(String boxName) async {
  final box = await Hive.openBox<T>(boxName);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final backupPath = '${appDocumentDir.path}/backup_$boxName.hive';
  final boxPath = box.path;
  await box.close();

  try {
    File(boxPath!).copy(backupPath);
  } finally {
    await Hive.openBox<T>(boxName);
  }
}

Future<void> restoreHiveBox<T>(String boxName) async {
  final box = await Hive.openBox<T>(boxName);
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final backupPath = '${appDocumentDir.path}/backup_$boxName.hive';
  final boxPath = box.path;
  await box.close();

  try {
    File(backupPath).copy(boxPath!);
  } on FileSystemException catch (e) {
    print('File not found: $e');
  } finally {
    await Hive.openBox<T>(boxName);
  }
}
