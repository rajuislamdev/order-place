import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Ref ref;
  LocalStorage(this.ref);

  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }
 Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token');
  return token;
}
  Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('currentUser');
  }

}

final localStorageProvider = Provider((ref) => LocalStorage(ref));
