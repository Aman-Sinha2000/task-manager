import 'package:shared_preferences/shared_preferences.dart';

class CSharedPreferencesServices {
  static CSharedPreferencesServices? _instance;
  static late SharedPreferences _preferences;

  CSharedPreferencesServices._();

  static Future<CSharedPreferencesServices> getInstance() async {
    _instance = CSharedPreferencesServices._();
    _preferences = await SharedPreferences.getInstance();
    return _instance!;
  }

  dynamic _getData(String key) {
    var value = _preferences.get(key);
    // print('Retrieved $key: $value');
    return value;
  }

  // Private method for saving data to shared preferences
  void _saveData(String key, dynamic value) {
    // print('Saving $key: $value');
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  static const String _userId = 'user-id-key';
  static const String _isLoggedIn = 'is-logged-in-key';
  static const String _userName = 'user-name-key';
  static const String _userEmail = 'user-email-key';

  String get userName => _getData(_userName) ?? '';
  set userName(String value) => _saveData(_userName, value);

  String get userId => _getData(_userId) ?? '';
  set userId(String value) => _saveData(_userId, value);

  String get userEmail => _getData(_userEmail) ?? '';
  set userEmail(String value) => _saveData(_userEmail, value);

  bool get isLoggedIn => _getData(_isLoggedIn) ?? false;
  set isLoggedIn(bool value) => _saveData(_isLoggedIn, value);
}
