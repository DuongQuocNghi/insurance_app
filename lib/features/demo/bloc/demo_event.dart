import 'package:equatable/equatable.dart';

abstract class DemoEvent extends Equatable {
  const DemoEvent();

  @override
  List<Object?> get props => [];
}

class UserFetched extends DemoEvent {
  const UserFetched();
}
