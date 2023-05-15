import 'package:mood_log/services/db.dart';

class SettingsController {
  DatabaseService db = DatabaseService();

  Future<String> getUserName() async {
    return await db.getUserName();
  }
}