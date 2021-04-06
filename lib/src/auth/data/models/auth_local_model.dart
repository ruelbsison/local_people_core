import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template AuthLocalModel}
/// AuthLocalModel model
///
/// [AuthLocalModel.empty] represents an unauthenticated AuthLocalModel.
/// {@endtemplate}
class AuthLocalModel extends Equatable {
  /// {@macro AuthLocalModel}
  const AuthLocalModel({
    @required this.userId,
    @required this.userName,
    @required this.userEmail,
    @required this.token,
    @required this.tokenExpirationDate,
  })  : assert(userId != null),
        assert(token != null);

  /// The current AuthLocalModel's id.
  final int userId;

  final String userName;

  final String userEmail;

  /// The current AuthLocalModel's name (display name).
  final String token;

  final DateTime tokenExpirationDate;

  /// Empty AuthLocalModel which represents an unauthenticated AuthLocalModel.
  static const empty = AuthLocalModel(userId: 0, userName: '', userEmail: '', token: '', tokenExpirationDate: null);

  @override
  List<Object> get props => [userId, userName, userEmail, token, tokenExpirationDate];
}
