part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}

class JobLocationLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class LoadJobLocationFailed extends LocationState {
  @override
  List<Object> get props => [];
}

class JobLocationLoaded extends LocationState {
  final Location location;

  JobLocationLoaded({@required this.location});

  @override
  List<Object> get props => [location];
}

class GetLocationLoading extends LocationState {
  @override
  List<Object> get props => [];
}

class GetLocationFailed extends LocationState {
  @override
  List<Object> get props => [];
}

class GetLocationLoaded extends LocationState {
  final Location location;

  GetLocationLoaded({@required this.location});

  @override
  List<Object> get props => [location];
}
