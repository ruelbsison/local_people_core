import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'trader_model.g.dart';

/// {@template TraderModel}
/// TraderModel model
///
/// [TraderModel.empty] represents an unauthenticated TraderModel.
/// {@endtemplate}
@JsonSerializable()
class TraderModel extends Equatable {
  int id;
  String name;
  String email;
  String intro;
  String token;
  String tokenExpirationDate;
  String createdAt;
  String updatedAt;

  TraderModel(
      {this.id,
        this.name,
        this.email,
        this.intro,
        this.token,
        this.tokenExpirationDate,
        this.createdAt,
        this.updatedAt});

  // TraderModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   email = json['email'];
  //   intro = json['intro'];
  //   token = json['token'];
  //   tokenExpirationDate = json['token_expiration_date'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['intro'] = this.intro;
  //   data['token'] = this.token;
  //   data['token_expiration_date'] = this.tokenExpirationDate;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }

  /// Empty ClientModel which represents an unauthenticated ClientModel.
  static empty() {
    new TraderModel(
      id: -1,
      name: '',
      email: '',
      intro: '',
      token: '',
      tokenExpirationDate: '',
      createdAt: '',
      updatedAt: '',
    );
  }

  @override
  List<Object> get props => [id, name, email, intro, token, tokenExpirationDate, createdAt, updatedAt];

  factory TraderModel.fromJson(Map<String, dynamic> json) => _$TraderModelFromJson(json);
  Map<String, dynamic> toJson() => _$TraderModelToJson(this);
}
