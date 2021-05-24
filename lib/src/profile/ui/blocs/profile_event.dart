import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileGetEvent extends ProfileEvent {}

class ProfileCreateEvent extends ProfileEvent {
  // const ProfileCreateEvent({@required this.profile});
  //
  // final dynamic profile;
  //
  // @override
  // List<Object> get props => [profile];
}

class ProfileGetTraderTopRatedEvent extends ProfileEvent {}



