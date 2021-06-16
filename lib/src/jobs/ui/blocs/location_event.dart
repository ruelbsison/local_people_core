part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class LoadJobLocationEvent extends LocationEvent {
  final int jobId;

  LoadJobLocationEvent({@required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class GetLocationEvent extends LocationEvent {
  final int id;

  GetLocationEvent({@required this.id});

  @override
  List<Object> get props => [id];
}
