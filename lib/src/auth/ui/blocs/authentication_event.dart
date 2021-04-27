part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class AuthenticateUser extends AuthenticationEvent {}

class ReAuthenticateUser extends AuthenticationEvent {}

class UnAuthenticateUser extends AuthenticationEvent {}