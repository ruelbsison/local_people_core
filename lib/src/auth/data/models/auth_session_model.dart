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
        assert(refreshToken != null),
        assert(accessToken != null);

  /// The current user's id.
  final String tokenId;

  final String refreshToken;

  final String accessToken;

  final DateTime expiredAt;

  /// Empty user which represents an unauthenticated user.
  static const empty = AuthSessionModel(tokenId: '', refreshToken: '', accessToken: '', expiredAt: null);

  @override
  List<Object> get props => [tokenId, refreshToken, accessToken, expiredAt];
}
