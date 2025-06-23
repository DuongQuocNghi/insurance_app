import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_app/app/config/app_config.dart';
import 'package:insurance_app/app/di/injection_container.dart';
import 'package:insurance_app/features/demo/bloc/demo_bloc.dart';
import 'package:insurance_app/features/demo/bloc/demo_event.dart';
import 'package:insurance_app/features/demo/bloc/demo_state.dart';
import 'package:insurance_app/features/demo/widgets/error_widget.dart';
import 'package:insurance_app/features/demo/widgets/loading_widget.dart';
import 'package:insurance_app/features/demo/widgets/info_widget.dart';
import 'package:insurance_app/features/demo/widgets/user_info_widget.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DemoBloc(
        demoRepository: sl(), locationService: sl(),
      )..add(const UserFetched()),
      child: Scaffold(
        backgroundColor: appColors.background,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<DemoBloc, DemoState>(
            builder: (context, state) {
              switch (state.status) {
                case DemoStatus.initial:
                  return const LoadingWidget();
                case DemoStatus.loading:
                  return const LoadingWidget();
                case DemoStatus.success:
                  if (state.user == null) {
                    return const LoadingWidget();
                  }
                  var isVisibleForecast = state.user?.results?.isNotEmpty ?? false;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(height:25,),
                                  // Hiển thị thông tin thời tiết hiện tại
                                  InfoWidget(info: state.user?.info, currentLocation: state.currentLocation),
                                  // Container(height: 62, width: 200, color: Colors.red,),
                                ],
                              ),
                            ),
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 1300),
                              curve: Curves.easeInOut,
                              left: 0, right: 0,
                              bottom: isVisibleForecast ? 0 : -constraints.maxHeight,
                              height: constraints.maxHeight - (isVisibleForecast ? 150 : 0),
                              // Hiển thị dự báo 4 ngày nếu có dữ liệu
                              child: UserInfoWidget(listUserInfo: state.user?.results,
                                onRefresh: () async => context.read<DemoBloc>().add(const UserFetched()),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  );
                case DemoStatus.failure:
                  return ErrorWidget(
                    errorMessage: state.errorMessage ?? 'Có lỗi xảy ra',
                    onRetry: () => context.read<DemoBloc>().add(const UserFetched()),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
