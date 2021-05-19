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
  final dynamic profile;

  const ProfileDoesNotExists(this.profile);

  @override
  String toString() {
    return 'ProfileDoesNotExists{e: $profile}';
  }
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
  final List<TraderProfile> traders;

  const ProfileTraderTopRatedCompleted(this.traders);

  @override
  String toString() {
  return 'ProfileCreated{e: $traders}';
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