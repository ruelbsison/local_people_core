import 'profile.dart';

class TraderProfile extends Profile {
  TraderProfile({
    rating = 0,
  }): super(fullName: 'Trader Name Here')
  {
    // empty contructor body
  }

  //TraderProfile.byId(int id): super(id: id);

  //TraderProfile.byUserId(int userId): super(userId: userId);
  int _rating;
  int get rating => _rating;
  set rating(int value) {
    this.rating = value;
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
}
