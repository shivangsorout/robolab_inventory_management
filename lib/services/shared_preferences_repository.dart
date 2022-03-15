import 'package:shared_preferences/shared_preferences.dart';

abstract class IStorage {
  Future get(String key);

  Future<void> save(String key, dynamic item);
}

class SharedPreferencesRepository implements IStorage {
  static String accessTokenKey = 'accessTokenKey';

  @override
  Future get(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<bool> save(String key, item) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, item);
  }

  Future<bool> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}