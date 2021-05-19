import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// {@template AuthLocalModel}
/// AuthLocalModel model
///
/// [AuthLocalModel.empty] represents an unauthenticated AuthLocalModel.
/// {@endtemplate}
class AuthLocalModel extends Equatable {
  /// {@macro AuthLocalModel}
  AuthLocalModel({
    @required this.userId,
    @required this.userFullName,
    @required this.userEmail,
    @required this.userPhoto,
    @required this.token,
    @required this.tokenExpirationDate,
  });//  : assert(userId != null),
     //   assert(token != null);

  /// The current AuthLocalModel's id.
  int userId;

  String userFullName;

  String userEmail;

  /// The current AuthLocalModel's name (display name).
  String token;

  DateTime tokenExpirationDate;

  String userPhoto;

  /// Empty AuthLocalModel which represents an unauthenticated AuthLocalModel.
  static empty() => AuthLocalModel(userId: 0, userFullName: '', userEmail: '', userPhoto: '', token: '', tokenExpirationDate: null);

  @override
  List<Object> get props => [userId, userFullName, userEmail, userPhoto, token, tokenExpirationDate];
}
