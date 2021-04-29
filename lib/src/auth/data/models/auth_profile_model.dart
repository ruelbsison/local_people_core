import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class AuthProfileModel extends Equatable {
  /// {@macro user}
  const AuthProfileModel({
    @required this.name,
    @required this.email,
    @required this.email_verified,
    @required this.photo,
  })  : assert(name != null),
        assert(email != null);

  /// The current user's id.
  final String name;

  final String email;

  final bool email_verified;

  final String photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthProfileModel(name: '', email: '', email_verified: false, photo: null);

  @override
  List<Object> get props => [name, email, email_verified, photo];
}
