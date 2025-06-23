import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:insurance_app/app/config/app_config.dart';
import 'package:insurance_app/app/config/font_config.dart';
import 'package:insurance_app/src/models/random_user_output.dart';

class InfoWidget extends StatelessWidget {
  final Info? info;
  final Position? currentLocation;

  const InfoWidget({super.key, required this.info, this.currentLocation});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCurrentWeather(context),
        _buildLocationInfo(),
      ],
    );
  }

  Widget _buildLocationInfo() {
    return Text(
      currentLocation.toString(),
      style: FontConfig.body.copyWith(
        color: appColors.blue_3,
      ),
    );
  }

  Widget _buildCurrentWeather(BuildContext context) {
    return Text(
      'Version: ${info?.version}',
      style: FontConfig.h3.copyWith(
        color: appColors.onBackground_9,
      ),
    );
  }
}
