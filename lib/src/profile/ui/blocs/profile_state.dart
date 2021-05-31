import 'package:equatable/equatable.dart';
import '../../domain/entities/client_profile.dart';
import '../../domain/entities/trader_profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ClientProfileLoaded extends ProfileState {
  final ClientProfile profile;

  const ClientProfileLoaded(this.profile);

  @override
  List<Object> get props {
    return [profile];
  }
}

class TraderProfileLoaded extends ProfileState {
  final TraderProfile profile;

  const TraderProfileLoaded(this.profile);

  @override
  List<Object> get props {
    return [profile];
  }
}

class ProfileNotLoaded extends ProfileState {
  final String e;

  const ProfileNotLoaded(this.e);

  @override
  String toString() {
    return 'ProfileNotLoaded{e: $e}';
  }
}

class ProfileDoesNotExists extends ProfileState {
  // final dynamic profile;
  //
  // const ProfileDoesNotExists(this.profile);
  //
  // @override
  // String toString() {
  //   return 'ProfileDoesNotExists{e: $profile}';
  // }
}

class ProfileCreating extends ProfileState {}

class ProfileCreated extends ProfileState {
  final dynamic profile;

  const ProfileCreated(this.profile);

  @override
  String toString() {
    return 'ProfileCreated{e: $profile}';
  }
}

class ProfileCreateFailed extends ProfileState {
  final String e;

  const ProfileCreateFailed(this.e);

  @override
  String toString() {
  return 'ProfileNotLoaded{e: $e}';
  }
}

class ProfileTraderTopRatedLoading extends ProfileState {}
class ProfileTraderTopRatedCompleted extends ProfileState {
  final List<TraderProfile> topRatedTraders;

  const ProfileTraderTopRatedCompleted(this.topRatedTraders);

  @override
  String toString() {
  return 'ProfileCreated{e: $topRatedTraders}';
  }
}

class ProfileTraderTopRatedFailed extends ProfileState {
  final String e;

  const ProfileTraderTopRatedFailed(this.e);

  @override
  String toString() {
    return 'ProfileTraderTopRatedFailed{e: $e}';
  }
}

class ClientProfileUpdating extends ProfileState {}

class ClientProfileUpdated extends ProfileState {
  final ClientProfile profile;

  const ClientProfileUpdated(this.profile);

  @override
  String toString() {
    return 'ClientProfile{e: $profile}';
  }
}

class ClientProfileUpdateFailed extends ProfileState {
  final String e;

  const ClientProfileUpdateFailed(this.e);

  @override
  String toString() {
    return 'ClientProfileUpdateFailed{e: $e}';
  }
}

class TraderProfileUpdating extends ProfileState {}

class TraderProfileUpdated extends ProfileState {
  final TraderProfile profile;

  const TraderProfileUpdated(this.profile);

  @override
  String toString() {
    return 'TraderProfile{e: $profile}';
  }
}

class TraderProfileUpdateFailed extends ProfileState {
  final String e;

  const TraderProfileUpdateFailed(this.e);

  @override
  String toString() {
    return 'TraderProfileUpdateFailed{e: $e}';
  }
}

class ClientProfileGetLoading extends ProfileState {}

class ClientProfileGetLoaded extends ProfileState {
  final ClientProfile profile;

  const ClientProfileGetLoaded(this.profile);

  @override
  String toString() {
    return 'ClientProfile{e: $profile}';
  }
}

class ClientProfileGetFailed extends ProfileState {
  final String e;

  const ClientProfileGetFailed(this.e);

  @override
  String toString() {
    return 'ClientProfileGetFailed{e: $e}';
  }
}

class TraderProfileGetLoading extends ProfileState {}

class TraderProfileGetLoaded extends ProfileState {
  final TraderProfile profile;

  const TraderProfileGetLoaded(this.profile);

  @override
  String toString() {
    return 'ClientProfile{e: $profile}';
  }
}

class TraderProfileGetFailed extends ProfileState {
  final String e;

  const TraderProfileGetFailed(this.e);

  @override
  String toString() {
    return 'ClientProfileGetFailed{e: $e}';
  }
}