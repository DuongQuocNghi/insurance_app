import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:insurance_app/app/config/language_config.dart';
import 'package:insurance_app/app/di/injection_container.dart' as di;
import 'package:insurance_app/features/demo/demo_page.dart';
import 'package:insurance_app/src/generated/i18n/app_localizations.dart';
import 'package:insurance_app/app/config/app_config.dart';
import 'package:insurance_app/app/config/font_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env file
  await dotenv.load();

  // Khởi tạo dependency injection
  await di.DependencyInjection.init();

  // Lấy cấu hình ngôn ngữ đã đăng ký
  final languageConfig = di.sl<LanguageConfig>();

  runApp(
    MaterialApp.router(
      title: appName,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: languageConfig.supportedLocales,
      locale: await languageConfig.getSavedLocale(),
      theme: ThemeData(
        textTheme: FontConfig.textTheme,
        primaryTextTheme: FontConfig.textTheme,
      ),
    ),
  );
}

/// This handles deepLink.
final router = GoRouter(
  errorBuilder: (_, __) => const WeatherPage(),
  routes: [GoRoute(path: '/', builder: (_, __) => const WeatherPage())],
);
