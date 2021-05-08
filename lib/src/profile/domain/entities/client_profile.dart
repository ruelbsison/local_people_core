import 'profile.dart';
import 'package:local_people_core/jobs.dart';

class ClientProfile extends Profile {
  ClientProfile({
    paymentMethodVerified = false,
    numOfJobsPosted = 0,
    numOfJobsInProgress = 0,
    amountSpent = 0.0,
    numOfDisputes = 0,
    recentJobs = const [],
  }): super(fullName: 'Client Name Here')
  {
  // empty contructor body
  }

  //ClientProfile.byId(int id): super(id: id);

  //ClientProfile.byUserId(int userId): super(userId: userId);

  List<Job> _recentJobs;
  List<Job> get recentJobs => _recentJobs;
  set recentJobs(List<Job> value) {
    this._recentJobs = value;
  }

  bool _paymentMethodVerified;
  bool get paymentMethodVerified => _paymentMethodVerified;
  set paymentMethodVerified(bool value) {
    this._paymentMethodVerified = value;
  }

  int _numOfJobsPosted;
  int get numOfJobsPosted => _numOfJobsPosted;
  set numOfJobsPosted(int value) {
    this._numOfJobsPosted = value;
  }

  int _numOfJobsInProgress;
  int get numOfJobsInProgress => _numOfJobsInProgress;
  set numOfJobsInProgress(int value) {
    this._numOfJobsInProgress = value;
  }

  double _amountSpent;
  double get amountSpent => _amountSpent;
  set amountSpent(double value) {
    this._amountSpent = value;
  }

  int _numOfDisputes;
  int get numOfDisputes => _numOfDisputes;
  set numOfDisputes(int value) {
    this._numOfDisputes = value;
  }

  int get id => super.id;
  set id(int value) {
    super.id = value;
  }

  int get userId => super.userId;
  set userId(int value) {
    super.userId = value;
  }

  String get description => super.description;
  set description(String value) {
    super.description = value;
  }

  String get address => super.address;
  set address(String value) {
    super.address = value;
  }

  String get intro => super.intro;
  set intro(String value) {
    super.intro = value;
  }

  String get fullName => super.fullName;
  set fullName(String value) {
    super.fullName = value;
  }

  String get photo => super.photo;
  set photo(String value) {
    super.photo = value;
  }

  DateTime get memberSince => super.memberSince;
  set memberSince(DateTime value) {
    super.memberSince = value;
  }

  String get email => super.email;
  set email(String value) {
    super.email = value;
  }

  static get empty => ClientProfile();
}
