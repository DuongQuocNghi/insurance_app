import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insurance_app/app/config/app_config.dart';
import 'package:insurance_app/core/widgets/button.dart';
import 'package:insurance_app/src/generated/i18n/app_localizations.dart';
import 'package:insurance_app/app/config/font_config.dart';

class ErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appColors.red_3,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kDebugMode ? errorMessage : 'Không thể tải dữ liệu',
                style: FontConfig.h2.copyWith(
                  color: appColors.onPrimaryLight,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 44),
              AppButton(
                height: null,
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                onPressed: onRetry,
                title: AppLocalizations.of(context)?.retry ?? 'Thử lại',
                backroundColor: appColors.onBackground_8,
                titleStyle: FontConfig.body.copyWith(color: appColors.surface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
