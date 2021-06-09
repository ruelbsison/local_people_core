import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:provider/provider.dart';
import '../entities/qualification.dart';
import 'package:local_people_core/jobs.dart';

class TraderProfile extends Equatable {
  TraderProfile({
    this.id = 0,
    this.userId = 0,
    this.photo = 'packages/local_people_core/assets/images/company-logo.png',
    this.fullName = 'Client Full Namme Here',
    this.memberSince = null,
    this.email = '',
    this.description = '',
    this.address = '',
    this.intro = '',
    this.ratingAvg = 0,
    this.token,
    this.tokenExpirationDate,
  }) {}

  int id;

  int userId;

  String description;

  String address;

  String intro;

  String fullName;

  String photo;

  DateTime memberSince;

  String email;

  double ratingAvg;

  String token;
  String tokenExpirationDate;

  List<Qualification> qualifications;

  List<Package> packages;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static get empty => TraderProfile();

  /// Wraps [ScopedModel.of] for this [Model].
  //static TraderProfile of(BuildContext context) =>
  //    ScopedModel.of<TraderProfile>(context);

  @override
  List<Object> get props => [id, userId, description, address, intro,
    fullName, photo, memberSince, email, ratingAvg, token, tokenExpirationDate];
}
