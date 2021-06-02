part of 'package_bloc.dart';

abstract class PackageEvent extends Equatable {
  const PackageEvent();
}

class PackageAddEvent extends PackageEvent {
  const PackageAddEvent({@required this.package});

  final Package package;

  @override
  List<Object> get props => [package];
}

class PackageDeleteEvent extends PackageEvent {
  const PackageDeleteEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class PackageGetEvent extends PackageEvent {
  const PackageGetEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}

class PackageUpdateEvent extends PackageEvent {
  const PackageUpdateEvent({@required this.package});

  final Package package;

  @override
  List<Object> get props => [package];
}