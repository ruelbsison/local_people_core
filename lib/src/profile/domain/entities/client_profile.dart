import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
//import 'package:scoped_model/scoped_model.dart';
//import 'package:provider/provider.dart';
import 'package:local_people_core/jobs.dart';

class ClientProfile extends Equatable {
  ClientProfile({
    this.id = 0,
    this.userId = 0,
    this.photo = 'packages/local_people_core/assets/images/company-logo.png',
    this.fullName = 'Client Full Namme Here',
    this.memberSince = null,
    this.email = '',
    this.description = '',
    this.address = '',
    this.intro = '',
    this.token,
    this.tokenExpirationDate,
    this.paymentMethodVerified = false,
    this.numOfJobsPosted = 0,
    this.numOfJobsInProgress = 0,
    this.amountSpent = 0.0,
    this.numOfDisputes = 0,
    this.recentJobs = const [],
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

  bool paymentMethodVerified;

  int numOfJobsPosted;

  int numOfJobsInProgress;

  double amountSpent;

  int numOfDisputes;

  List<Job> recentJobs;

  String token;
  String tokenExpirationDate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;

  static get empty => ClientProfile();

  /// Wraps [ScopedModel.of] for this [Model].
  //static ClientProfile of(BuildContext context) =>
  //    ScopedModel.of<ClientProfile>(context);

  @override
  List<Object> get props => [id, userId, description, address, intro, fullName, photo, memberSince, email, paymentMethodVerified, numOfJobsPosted,
    numOfJobsInProgress, amountSpent, numOfDisputes, recentJobs, token, tokenExpirationDate];

  // static get empty => ClientProfile(id: 0, userId: 0, fullName: '', photo: '', memberSince: null,
  //     email: '', description: '', address: '', intro: '');
}
