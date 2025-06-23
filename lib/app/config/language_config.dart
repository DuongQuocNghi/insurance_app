import 'package:flutter/material.dart';
import 'package:insurance_app/services/local_storage_service.dart';

/// Lớp quản lý cấu hình ngôn ngữ ứng dụng
class LanguageConfig {
  final LocalStorageService _localStorageService;

  LanguageConfig(this._localStorageService);

  /// Lấy locale đã lưu từ storage
  Future<Locale?> getSavedLocale() async {
    final languageCode = await _localStorageService.getLanguage();
    if (languageCode == null || languageCode.isEmpty) {
      return null;
    }
    return Locale(languageCode);
  }

  /// Lưu locale được chọn
  Future<void> saveLocale(Locale locale) async {
    await _localStorageService.saveLanguage(locale.languageCode);
  }

  /// Danh sách ngôn ngữ được hỗ trợ
  List<Locale> get supportedLocales => const [
    Locale('en'), // English
    Locale('vi'), // Vietnamese
  ];
}
