import 'package:shared_preferences/shared_preferences.dart';

/// Interface định nghĩa các phương thức lưu trữ cục bộ
abstract class LocalStorageService {
  /// Lưu ngôn ngữ đã chọn
  Future<void> saveLanguage(String? value);

  /// Lấy ngôn ngữ đã lưu
  Future<String?> getLanguage();
}

/// Implementation sử dụng SharedPreferences
class SharedPrefsStorage implements LocalStorageService {
  final SharedPreferences _prefs;

  // Các khóa lưu trữ
  static const String _languageKey =
      'vpaSBRhqTLTBWoo8PM14usLTPtFqjXCoXqX2WEqusntf';

  SharedPrefsStorage(this._prefs);

  @override
  Future<void> saveLanguage(String? value) async {
    await _prefs.setString(_languageKey, value ?? '');
  }

  @override
  Future<String?> getLanguage() async {
    return _prefs.getString(_languageKey);
  }
}
