import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';

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

class ClientProfileUpdateEvent extends ProfileEvent {
  const ClientProfileUpdateEvent({@required this.profile});

  final ClientProfile profile;

  @override
  List<Object> get props => [profile];
}

class TraderProfileUpdateEvent extends ProfileEvent {
  const TraderProfileUpdateEvent({@required this.profile});

  final TraderProfile profile;

  @override
  List<Object> get props => [profile];
}

class ClientProfileGetEvent extends ProfileEvent {
  const ClientProfileGetEvent({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}



