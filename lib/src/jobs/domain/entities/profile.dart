import 'dart:ui';

class Profile1 extends Object {
  final int userId;
  final String fullName;
  final String photoUrl;
  final DateTime memberSince;
  final String email;
  final int jobsPosted;

  const Profile1({
    this.userId,
    this.fullName,
    this.photoUrl,
    this.memberSince,
    this.email,
    this.jobsPosted,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => userId;

  static const empty = Profile1(userId: 0, fullName: '', photoUrl: '', memberSince: null,
      email: '', jobsPosted: 0);

  static const demo = Profile1(userId: 1, fullName: 'Client Name', photoUrl: '', memberSince: null,
      email: '', jobsPosted: 0);
}
