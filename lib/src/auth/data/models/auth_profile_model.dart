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
  static empty() => AuthProfileModel(name: '', email: '', email_verified: false, photo: null);
  static clientDefault() => AuthProfileModel(name: 'Ruel Sison', email: 'rsjudge17@gmil.com', email_verified: true, photo: 'packages/local_people_core/assets/images/company-logo.png');
  static traderDefault() => AuthProfileModel(name: 'Ruel Sison', email: 'rsjudge17@hotmail.com', email_verified: true, photo: 'packages/local_people_core/assets/images/company-logo.png');

  @override
  List<Object> get props => [name, email, email_verified, photo];
}
