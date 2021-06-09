import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class AuthSessionModel extends Equatable {
  /// {@macro user}
  const AuthSessionModel({
    @required this.tokenId,
    @required this.refreshToken,
    @required this.accessToken,
    @required this.expiredAt,
  })  : assert(tokenId != null),
        assert(accessToken != null);

  /// The current user's id.
  final String tokenId;

  final String refreshToken;

  final String accessToken;

  final DateTime expiredAt;

  /// Empty user which represents an unauthenticated user.
  static empty() => AuthSessionModel(tokenId: '',
      refreshToken: '',
      accessToken: '', expiredAt: DateTime.now().add(Duration(days: 1)));

  static defaultAuth() => AuthSessionModel(tokenId: 'tokenid',
    refreshToken: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ii0zMndiMC15aEQ1U2FyM01CTm82QyJ9',
    accessToken: '', expiredAt: DateTime.now().add(Duration(days: 1)));

  @override
  List<Object> get props => [tokenId, refreshToken, accessToken, expiredAt];
}
