import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/trader_profile.dart';
import 'package:local_people_core/auth.dart';
import 'package:intl/intl.dart';

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
  String token_expiration_date;
  String created_at;
  String updated_at;

  TraderModel(
      {this.id,
        this.name,
        this.email,
        this.intro,
        this.token,
        this.token_expiration_date,
        this.created_at,
        this.updated_at});

  static TraderModel fromTraderProfile(TraderProfile profile) {
    return TraderModel(
      id: profile.id,
      name: profile.fullName,
      email: profile.email,
      intro: profile.intro,
      created_at: profile.memberSince.toString(),
    );
  }

  static TraderModel fromTraderProfileAndAuth(TraderProfile profile, AuthLocalModel authLocalModel) {
    return TraderModel(
      id: authLocalModel.userId,
      name: profile.fullName,
      email: profile.email,
      intro: profile.intro,
      created_at: profile.memberSince.toString(),
        token: authLocalModel.token,
        token_expiration_date: DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(authLocalModel.tokenExpirationDate),
    );
  }

  // TraderModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   email = json['email'];
  //   intro = json['intro'];
  //   token = json['token'];
  //   token_expiration_date = json['token_expiration_date'];
  //   created_at = json['created_at'];
  //   updated_at = json['updated_at'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['intro'] = this.intro;
  //   data['token'] = this.token;
  //   data['token_expiration_date'] = this.token_expiration_date;
  //   data['created_at'] = this.created_at;
  //   data['updated_at'] = this.updated_at;
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
      token_expiration_date: '',
      created_at: '',
      updated_at: '',
    );
  }

  @override
  List<Object> get props => [id, name, email, intro, token, token_expiration_date, created_at, updated_at];

  factory TraderModel.fromJson(Map<String, dynamic> json) => _$TraderModelFromJson(json);
  Map<String, dynamic> toJson() => _$TraderModelToJson(this);
}
