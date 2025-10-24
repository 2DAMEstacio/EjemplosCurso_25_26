import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static const _keyAuthToken = 'auth_token';
  static const _keyEmail = 'user_email';

  Future<void> saveAuth({required String email, required String token}) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_keyAuthToken, token);
    await sp.setString(_keyEmail, email);
  }

  Future<void> clearAuth() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_keyAuthToken);
    await sp.remove(_keyEmail);
  }

  Future<String?> getToken() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_keyAuthToken);
  }

  Future<String?> getEmail() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_keyEmail);
  }
}
