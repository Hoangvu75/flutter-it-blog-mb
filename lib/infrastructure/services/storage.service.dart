import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/util/constants.dart';

@lazySingleton
class StorageService {
  late Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  final String _tokenKey = Constants.ACCESS_TOKEN_KEY;

  Future<void> saveToken(String token) async {
    await prefs.then((value) => value.setString(_tokenKey, token));
  }

  Future<String?> getToken() async {
    return prefs.then((value) => value.getString(_tokenKey));
  }

  Future<void> removeToken() async {
    await prefs.then((value) => value.remove(_tokenKey));
  }
}
