import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:geolocator/geolocator.dart';
import 'package:insurance_app/features/demo/bloc/demo_event.dart';
import 'package:insurance_app/features/demo/bloc/demo_state.dart';
import 'package:insurance_app/repositories/demo_repository.dart';
import 'package:insurance_app/services/location_service.dart';

class DemoBloc extends Bloc<DemoEvent, DemoState> {
  final DemoRepository weatherRepository;
  final LocationService locationService;

  DemoBloc({required this.weatherRepository, required this.locationService})
    : super(const DemoState()) {
    on<UserFetched>(_onUserFetched, transformer: droppable());
  }

  Future<void> _onUserFetched(
    UserFetched event,
    Emitter<DemoState> emit,
  ) async {
    if (state.status == DemoStatus.loading) return;

    emit(state.copyWith(status: DemoStatus.loading));

    try {
      final Position position = await locationService.getCurrentLocation();
      final user = await weatherRepository.getRandomUser();

      emit(state.copyWith(status: DemoStatus.success, user: user, currentLocation: position));
    } catch (e) {
      emit(
        state.copyWith(
          status: DemoStatus.failure,
          errorMessage: 'Có lỗi xảy ra: ${e.toString()}',
        ),
      );
    }
  }
}
