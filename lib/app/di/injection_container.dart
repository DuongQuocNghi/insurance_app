import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:insurance_app/app/config/language_config.dart';
import 'package:insurance_app/repositories/demo_repository.dart';
import 'package:insurance_app/services/local_storage_service.dart';
import 'package:insurance_app/services/location_service.dart';
import 'package:insurance_app/services/demo_service.dart';

/// Singleton instance của GetIt
final sl = GetIt.instance;

/// Khởi tạo dependency injection
class DependencyInjection {
  /// Cấu hình tất cả dependencies
  static Future<void> init() async {
    // External
    sl.registerLazySingleton<http.Client>(() => http.Client());
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

    // Services
    sl.registerLazySingleton<DemoService>(
      () => DemoServiceImp(client: sl<http.Client>()),
    );
    sl.registerLazySingleton<LocationService>(() => DefaultLocationService());
    sl.registerLazySingleton<LocalStorageService>(
      () => SharedPrefsStorage(sl<SharedPreferences>()),
    );

    // Repositories
    sl.registerLazySingleton<DemoRepository>(
      () => DemoRepositoryImp(weatherService: sl<DemoService>()),
    );

    // Config
    sl.registerLazySingleton<LanguageConfig>(
      () => LanguageConfig(sl<LocalStorageService>()),
    );
  }
}
