import 'package:flutter/material.dart';
import 'package:insurance_app/app/di/injection_container.dart';
import 'package:insurance_app/core/assets/colors.dart';
import 'package:insurance_app/app/config/language_config.dart';

/// Tên ứng dụng
const String appName = 'Weather';

/// Màu sắc mặc định của ứng dụng
AppColor appColors = AppLightTheme();

/// Lớp tiện ích để truy cập cấu hình và dịch vụ toàn cục
class AppConfig {
  /// Lấy cấu hình ngôn ngữ từ DI container
  static LanguageConfig get languageConfig => sl<LanguageConfig>();

  /// Lấy locale hiện tại
  static Future<Locale?> getCurrentLocale() async {
    return await languageConfig.getSavedLocale();
  }

  /// Lưu ngôn ngữ mới
  static Future<void> saveLanguage(String languageCode) async {
    await languageConfig.saveLocale(Locale(languageCode));
  }
}
