import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:insurance_app/src/models/random_user_output.dart';

enum DemoStatus { initial, loading, success, failure }

class DemoState extends Equatable {
  final DemoStatus status;
  final RandomUserOutput? user;
  final String? errorMessage;
  final Position? currentLocation;

  const DemoState({
    this.status = DemoStatus.initial,
    this.user,
    this.errorMessage,
    this.currentLocation,
  });

  DemoState copyWith({
    DemoStatus? status,
    RandomUserOutput? user,
    String? errorMessage,
    Position? currentLocation,
  }) {
    return DemoState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, currentLocation];
}
