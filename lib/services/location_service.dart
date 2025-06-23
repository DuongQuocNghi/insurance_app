import 'package:geolocator/geolocator.dart';
import 'package:insurance_app/core/errors/exceptions.dart';
import 'package:insurance_app/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Interface định nghĩa các phương thức làm việc với vị trí địa lý
abstract class LocationService {
  /// Lấy vị trí hiện tại của người dùng
  Future<Position> getCurrentLocation();
}

/// Implementation mặc định của LocationService
class DefaultLocationService implements LocationService {
  final BuildContext? context;

  DefaultLocationService({this.context});

  @override
  /// Lấy vị trí hiện tại của người dùng
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Kiểm tra xem dịch vụ định vị có được bật không
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(
        message:
            context != null
                ? AppLocalizations.of(context!)?.location_service_disabled ??
                    'Location services are disabled. Please enable them.'
                : 'Location services are disabled. Please enable them.',
      );
    }

    // Kiểm tra quyền truy cập vị trí
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException(
          message:
              context != null
                  ? AppLocalizations.of(context!)?.location_permission_denied ??
                      'Location permissions are denied.'
                  : 'Location permissions are denied.',
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        message:
            context != null
                ? AppLocalizations.of(
                      context!,
                    )?.location_permission_denied_forever ??
                    'Location permissions are permanently denied, we cannot request permissions.'
                : 'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // Lấy vị trí hiện tại
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      throw LocationException(message: e.toString());
    }
  }
}
