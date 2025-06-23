import 'package:flutter/material.dart';
import 'package:insurance_app/app/config/font_config.dart';
import 'package:insurance_app/src/models/random_user_response.dart';
import 'package:insurance_app/app/config/app_config.dart';

class UserInfoWidget extends StatelessWidget {
  final List<UserInfo>? listUserInfo;
  final RefreshCallback onRefresh;

  const UserInfoWidget({super.key, required this.listUserInfo, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return listUserInfo == null ? SizedBox() : Container(
      decoration: BoxDecoration(
        color: appColors.surface,
        boxShadow: [
          BoxShadow(
            color: appColors.onBackground_3,
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ListView.builder(
            itemCount: listUserInfo?.length,
              itemBuilder: (context, index) => _buildItem(listUserInfo?[index])),
        ),
      ),
    );
  }

  Widget _buildItem(UserInfo? e){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e?.name?.first ?? '',
                  style: FontConfig.body.copyWith(
                    color: appColors.onBackground_9,
                    height: 1.2
                  ),
                ),
                Text(e?.email ?? '',
                  style: FontConfig.body.copyWith(
                      color: appColors.onBackground_9,
                      height: 1.2
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: appColors.onBackground_2,)
        ],
      ),
    );
  }
}
