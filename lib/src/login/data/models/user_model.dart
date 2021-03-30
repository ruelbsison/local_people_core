import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String name;
  String email;
  String token;
  String tokenExpirationDate;

  UserModel({this.id, this.name, this.email, this.token, this.tokenExpirationDate});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /*factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      token: json['token'],
      tokenExpirationDate: json['token_expiration_date'],
    );
  }

  Map<String, dynamic> toJson(UserModel data) {
    return {
      'id': data.id,
      'email': data.email,
      'name': data.name,
      'token': data.token,
      'tokenExpirationDate': data.tokenExpirationDate,
    };
  }*/
}